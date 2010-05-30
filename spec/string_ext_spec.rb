require 'spec_helper'
require 'pratt'

describe String do
  it { subject.should respond_to(:colorize) }
  it { subject.should respond_to(:or) }
  it { subject.should respond_to(:with_label) }

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
    "abc".blue.should eql("abc")
  end

  it "colorizes when Pratt.color? == true" do
    Pratt.color = true
    "abc".blue.should eql("\e[34mabc\e[0m")
  end

  it "handles with_label as expected" do
    Project.expects(:longest_project_name).returns 11
    "abc".with_label("label").should eql("      label abc")
  end
end
