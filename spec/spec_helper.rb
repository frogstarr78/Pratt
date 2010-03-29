# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'spec'
require 'lib/pratt'
require 'ruby-debug'

Spec::Runner.configure do |config|
#  config.mock_with :rspec
  config.mock_with :mocha

  Pratt.connect! 'test'

  Customer.create(
	:name         => 'Scott Noel-Hemming',
	:company_name => 'Frogstarr78 Software',
	:address      => '312 NW 7th',
	:phone        => '509.730.5401',
	:zip          => '97862'
  ) unless Customer.count > 0

  Project.create(
	[
	  {
		:name => 'Refactor',
		:weight => 1,
		:customer_id => 0
	  },
	  {
		:name => 'Lunch/Break',
		:weight => 0,
		:customer_id => 0
	  },
	  {
		:name => 'Other',
		:weight => -1,
		:customer_id => 0
	  }
	]
  ) unless Project.count > 0
end

shared_examples_for "Time spent on a project" do
end

shared_examples_for "being a billable item" do
  it "responds to amount" do
    subject.class.new.should respond_to(:amount) 
  end
end
