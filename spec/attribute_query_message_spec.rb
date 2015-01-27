#encoding: utf-8

require_relative '../attribute_query_message'

describe AttributeQueryMessage do
  before(:each) do
    @issuer_id = "https://my-server.example.org/sp"
  end
  it "simply requires nameid and issuer_id" do
    soap = AttributeQueryMessage.new "caio", @issuer_id
    expect(soap.format).to match @issuer_id
  end

  it "formats request_id" do
    soap = AttributeQueryMessage.new "caio", @issuer_id
    expect(soap.instance_eval "@request_id").to match /^_\S{32}$/ 
  end

  it "formats issue_instant" do
    soap = AttributeQueryMessage.new "caio", @issuer_id
    expect(soap.instance_eval "@issue_instant").to be_eql Time.new.utc.strftime("%Y-%m-%dT%H:%M:%SZ") 
  end


end

