#encoding: utf-8

require_relative '../query_agent'

describe QueryAgent do
  before(:each) do
    @query = double("query")
    @agent = QueryAgent.new @query
  end

  it "initializes with a query object" do    
    expect(@agent)
    expect(@agent.instance_eval("@query")).to be_eql @query
  end

  it "expects hamster messages" do
    msg = Hamster::Hash.new(type: :xml, payload: "data")
    expect(@query).to receive :perform
    @agent.on_message msg
  end

end

