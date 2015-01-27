#encoding: utf-8

require 'time'
require 'erb'

class AttributeQueryMessage
  def initialize(nameid, issuer_id)
    @issuer_id = issuer_id
    @nameid = nameid
    @issue_instant = Time.new.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    @request_id = "_#{rand(2 ** 128).to_s(16)}"
  end
  
  def format
    template = ERB.new(File.read("attribute_query_message.xml.erb"))
    template.result binding
  end
end
