#encoding: utf-8

require_relative '../query'

describe Query do
  before(:each) do
    @url = "https://idp.example.org:8443/idp/profile/SAML1/SOAP/AttributeQuery"
    @cert_file = "./certs/sp-cert.pem"
    @key_file = "./certs/sp-key.pem"
    @cacert = "idp3.pem"
  end
  it "initializes with a url, cert and key" do
    query = Query.new @url, @cert_file, @key_file, @cacert
    expect(query)
  end

  it "if missing cert, complains" do
    expect { Query.new @url, "./wrong/#{@cert_file}", @key_file, @cacert }.to raise_error IOError
  end

end

