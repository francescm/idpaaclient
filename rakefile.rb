#encoding: utf-8

$:.unshift "."


require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'query'
require 'attribute_query_message'
require 'pp'

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


desc "esegue una query"
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
  result.xpath("//saml1:Attribute").each do |node|
	scope = unless node.children.first.attributes.empty?
			node.children.first.attributes["Scope"].value
		end
	
        puts "#{node.attributes["AttributeName"].value} => #{node.text} #{ scope ? "@" : ""} #{scope}"
  end
end
