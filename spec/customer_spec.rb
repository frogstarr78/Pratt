require 'spec_helper'
require 'pratt'

describe Customer do
  describe "instance" do
    before :each do
      @customer = Customer.new
    end

    it "responds to :projects" do
      @customer.should respond_to(:projects)
    end

    it "responds to :payment" do
      @customer.should respond_to(:payment)
    end
  end
end
