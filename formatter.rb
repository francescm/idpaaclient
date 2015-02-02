#encoding: utf-8

require 'nokogiri'

class Formatter
  def initialize(xml)
    @xml = xml
  end

  def format
    xml_doc  = Nokogiri::XML @xml
    output = []
    xml_doc.xpath("//saml1:Attribute", 'saml1' => 'urn:oasis:names:tc:SAML:1.0:assertion').each do |node|
      attr_name = node.xpath("@AttributeName")
      node.xpath("./saml1:AttributeValue", 'saml1' => 'urn:oasis:names:tc:SAML:1.0:assertion').each do |value|
        scope = value.xpath("@Scope", 'saml1' => 'urn:oasis:names:tc:SAML:1.0:assertion').to_s
        attr_value = value.text
        output << "#{attr_name} => #{attr_value} #{ scope.eql?("") ? "" : "@"} #{scope}".strip
      end
    end
    output.join("\n")
  end

end
