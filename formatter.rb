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
      scope = node.xpath("//saml1:AttributeValue[@Scope]/@Scope", 'saml1' => 'urn:oasis:names:tc:SAML:1.0:assertion').to_s
      attr_name = node.xpath("@AttributeName")
      attr_value = node.xpath("./saml1:AttributeValue", 'saml1' => 'urn:oasis:names:tc:SAML:1.0:assertion').text

      output << "#{attr_name} => #{attr_value} #{ scope ? "@" : ""} #{scope}"
    end
    output.join("\n")
  end

end
