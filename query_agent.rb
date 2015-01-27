#encoding: utf-8

require 'concurrent'
require_relative 'query'

class QueryAgent < Concurrent::Actor::Context
  def initialize(query)
    @query = query
  end

  def on_message(xml)
    @query.perform xml
  end

end
