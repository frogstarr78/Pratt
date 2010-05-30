require 'spec_helper'
require 'pratt'

describe String do
  it { subject.should respond_to(:colorize) }
  it { subject.should respond_to(:or) }

  it "doesn't process alternate format when Pratt.color? == false" do
    Pratt.color = false
    "abc".or("xyz").should eql("abc")
  end

  it "processes alternate format when Pratt.color? == true" do
    Pratt.color = true
    "abc".or("xyz").should eql("xyz")
  end

  it "doesn't colorize when Pratt.color? == false" do
    Pratt.color = false
    "abc".red.should eql("abc")
  end

  it "colorizes when Pratt.color? == true" do
    Pratt.color = true
    "abc".red.should eql("\e[31mabc\e[0m")
  end
end
