require 'spec_helper'
require 'pratt'

describe Numeric do
  it { 1.should respond_to(:format_integer) }
  it { 1.should respond_to(:with_label) }

  it "should format correctly" do
    Pratt.color = false
    1.format_integer.should eql("01")
  end

  it '"format" with with_label' do
    Pratt.color = false
    Project.expects(:longest_project_name).returns(11)
    1.with_label(:blue).should eql("       blue 1")
  end

  it "recursively applies formatting without color" do
    Pratt.color = false
    Project.expects(:longest_project_name).returns(11)
    1.format_integer.blue.with_label("#").should eql("          # 01")
  end

  it "recursively applies formatting with color" do
    Pratt.color = true
    Project.expects(:longest_project_name).returns(11)
    1.format_integer.blue.with_label("#").should eql("          # \e[34m01\e[0m")
  end
end
