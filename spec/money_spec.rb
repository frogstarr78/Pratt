require 'spec_helper'
require 'pratt'

describe Money do
  it "generates expected pretty_print output" do
    @money = Money.new 2.5
    @money.pretty_print.should eql("$2.50")
  end
end
