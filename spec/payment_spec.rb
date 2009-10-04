require 'spec_helper'
require 'pratt'

describe Payment do
  describe "instances" do
    before :each do
      @payment = Payment.new
    end
   
    it "responds to :pretty_print" do
      @payment.should respond_to(:pretty_print)
    end

    it "pretty_print is the expected format " do
      @payment.rate = '100'
      @payment.pretty_print.should == '$1.00'
    end
  end
end
