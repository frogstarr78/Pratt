require 'spec_helper'
require 'pratt'

describe Float do
  it { 2.0.should respond_to(:format_integer_with_label) }

  it "should format correctly with no color" do
    Pratt.color = false
    2.0.format_integer_with_label("#", :red).should eql("02 #")
  end

  it "should format correctly with color" do
    Pratt.color = true
    2.0.format_integer_with_label("#", :red).should eql("\e[31m02\e[0m #")
  end
end
