require 'spec_helper'
require 'pratt'

describe Money do
  it "pretty_print generates formatted string" do
    @money = Money.new 2.5
    @money.pretty_print.should eql("$2.50")
  end
end
