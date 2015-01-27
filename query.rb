#encoding: utf-8

require 'savon'
require_relative 'attribute_query_message'

class Query
  def initialize(url, cert_file, key_file, cacert)
    raise IOError, "missing cert file #{cert_file}" unless File.exists? cert_file
    raise IOError, "missing cert file #{key_file}" unless File.exists? key_file
    raise IOError, "#{key_file} permissions wrong (world readable)" if File.world_readable? key_file

    @client = Savon.client do
      endpoint url
      namespace "urn:oasis:names:tc:SAML:2.0:protocol"
      ssl_cert_file cert_file
      ssl_cert_key_file key_file
      ssl_ca_cert_file cacert
      #log true
      #log_level :debug
    end

  end

  def perform(data_binary)
    begin
      # execute request
      response = @client.call "http://www.oasis-open.org/committees/security", :xml => data_binary
      
    rescue Savon::Error => fault
      puts fault.to_s
    end
    response 

  end
  
end
