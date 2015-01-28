#encoding: utf-8

require_relative '../formatter'

describe Formatter do
  before(:each) do
    @xml = File.open("./spec/soap.xml").read
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

  it "format xml handles scope" do
    f = Formatter.new @xml
    output = f.format
    output.split("\n").each do |line|
      if line.match /eduPersonPrincipalName/
        expect(line).to match /example.org/
      else
        expect(line).not_to match /example.org/
      end
    end

  end

end

