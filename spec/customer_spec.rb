require 'spec_helper'
require 'pratt'

describe Customer do
  it_should_behave_like "being a billable item"

  describe "instance" do
    before :each do
      @customer = Customer.create :name => "frogstarr78", :address => '312 NW 7th', :zip => '97862'
    end

    after :each do
      Customer.find_by_name('frogstarr78').destroy
    end

    it "responds to :projects" do
      Customer.new.should respond_to(:projects)
    end

    it "responds to :payment" do
      Customer.new.should respond_to(:payment)
    end

    it "calculates amount correctly" do
      payment = mock('payment')
      payment.expects(:rate).once.returns(31500)
      @customer.expects(:payment).once.returns(payment)
      @customer.amount.should == 315.0
    end
  end
end
