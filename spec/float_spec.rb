require 'spec_helper'
require 'pratt'

describe Float do
  it { 2.0.should respond_to(:format_integer) }
  it { 2.0.should respond_to(:percentage) }

  it "should format correctly" do
    2.0.format_integer.should eql("02")
  end

  it "shows percentage correctly with no total" do
    2.3.percentage.should eql("230.00%")
  end

  it "shows percentage correctly with total" do
    2.5.percentage(5).should eql("50.00%")
  end

  it "handles with_label as expected" do
    Project.expects(:longest_project_name).returns 21
    3.5.with_label("label").should eql("                label 3.5")
  end
end
