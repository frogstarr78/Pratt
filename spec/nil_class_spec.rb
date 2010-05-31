require 'spec_helper'
require 'pratt'

describe NilClass do
  it "generates expected pretty_print output" do
    nil.pretty_print.should eql("")
  end
end
