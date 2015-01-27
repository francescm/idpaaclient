#encoding: utf-8

require_relative '../formatter'

describe Formatter do
  before(:each) do
    @xml =<<XML
<?xml version="1.0" encoding="UTF-8"?>
<soap11:Envelope xmlns:soap11="http://schemas.xmlsoap.org/soap/envelope/"><soap11:Body><saml1p:Response InResponseTo="_fad0e9ee80f235ecbfae7dfca3392471" IssueInstant="2015-01-27T09:39:56.112Z" MajorVersion="1" MinorVersion="1" ResponseID="_ef89dfcdf7e5edd16a2107eee8c26ba0" xmlns:saml1p="urn:oasis:names:tc:SAML:1.0:protocol"><saml1p:Status><saml1p:StatusCode Value="saml1p:Success"/></saml1p:Status><saml1:Assertion AssertionID="_867974853e9d60028dc1600962fb4e02" IssueInstant="2015-01-27T09:39:56.112Z" Issuer="https://idp3.example.org/idp/shibboleth" MajorVersion="1" MinorVersion="1" xmlns:saml1="urn:oasis:names:tc:SAML:1.0:assertion"><saml1:Conditions NotBefore="2015-01-27T09:39:56.112Z" NotOnOrAfter="2015-01-27T09:44:56.112Z"><saml1:AudienceRestrictionCondition><saml1:Audience>https://moodle-shib.example.org/sp</saml1:Audience></saml1:AudienceRestrictionCondition></saml1:Conditions><saml1:AttributeStatement><saml1:Subject><saml1:NameIdentifier Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">john_doe</saml1:NameIdentifier><saml1:SubjectConfirmation><saml1:ConfirmationMethod>urn:oasis:names:tc:SAML:1.0:cm:sender-vouches</saml1:ConfirmationMethod></saml1:SubjectConfirmation></saml1:Subject><saml1:Attribute AttributeName="urn:mace:dir:attribute-def:uid" AttributeNamespace="urn:mace:shibboleth:1.0:attributeNamespace:uri"><saml1:AttributeValue>john_doe</saml1:AttributeValue></saml1:Attribute><saml1:Attribute AttributeName="urn:mace:dir:attribute-def:eduPersonPrincipalName" AttributeNamespace="urn:mace:shibboleth:1.0:attributeNamespace:uri"><saml1:AttributeValue Scope="example.org">john_doe</saml1:AttributeValue></saml1:Attribute></saml1:AttributeStatement></saml1:Assertion></saml1p:Response></soap11:Body></soap11:Envelope>
XML
  end

  it "initializes with a xml" do
    f = Formatter.new @xml
    expect(f)
  end

  it "format xml in text" do
    f = Formatter.new @xml
    output = f.format
    expect(output).to match /john_doe/
    expect(output.split("\n").count).to be_eql 2
  end

end

