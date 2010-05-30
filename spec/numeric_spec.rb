require 'spec_helper'
require 'pratt'

describe Numeric do
  it { 1.should respond_to(:format_integer_with_label) }

  it "should format correctly with no color" do
    Pratt.color = false
    1.format_integer_with_label("#", :red).should eql("01 #")
  end

  it "should format correctly with color" do
    Pratt.color = true
    1.format_integer_with_label("#", :red).should eql("\e[31m01\e[0m #")
  end
end
