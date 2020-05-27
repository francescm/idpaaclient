#encoding: utf-8

require 'concurrent'
require 'concurrent-edge'
require_relative 'query'
require 'hamster'

class QueryAgent < Concurrent::Actor::Context
  def initialize(query)
    @query = query
  end

  def on_message(msg)
    case msg[:type]
    when :xml
      perform msg[:payload]
    when :report
      report
    end
  end

  private
  def perform(xml)
    @result = @query.perform xml
  end
  
  def report
    @result
  end

end
