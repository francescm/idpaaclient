#encoding: utf-8

$:.unshift "."


require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'query'
require 'attribute_query_message'
require 'pp'
require 'query_agent'
require 'formatter'

task :default => [:spec]

RSpec::Core::RakeTask.new(:spec) 

task :setup do
  config_file = "config.yaml"
  config = YAML.load_file(config_file)
  @issuer_id = config[:issuer_id]
  @url = config[:url]	
  @cert_file = config[:cert]
  @cacert = config[:cacert]
  @key_file = config[:key]
end


desc "queries the AA, concurrent"
task :concurrent => :setup do
  uid_list = ENV["uidlist"]
  if !uid_list
    puts "usage: rake #{task.name} uidlist=a_uid,b_uid ... (comma separated)"
    exit 0
  end
  actors = []
  query = Query.new(@url, @cert_file, @key_file, @cacert)
  uids = uid_list.split(",")
  outputs = []
  uids.each do |uid|
    msg = AttributeQueryMessage.new(uid, @issuer_id)
    xml = msg.format
    actor = QueryAgent.spawn(uid, query)
    result = actor.ask xml
    outputs << Formatter.new(result.value.to_xml).format
    actors << actor
  end
  actors.each do |actor|
    actor.tell :terminate!                           # => #<Concurrent::Actor::Reference /first (Counter)>
    actor.ask! :terminated?                          # => true
  end

  puts outputs
end

desc "queries the AA"
task :query => :setup do
  uid = ENV["uid"]
  if !uid
    puts "usage: rake #{task.name} uid=a_uid"
    exit 0
  end
  msg = AttributeQueryMessage.new(uid, @issuer_id)
  binary_data = msg.format
  puts binary_data
  query = Query.new(@url, @cert_file, @key_file, @cacert)
  result = query.perform(binary_data)
  # what about a class to handle presentation?
  puts Formatter.new(result.to_xml).format

end
