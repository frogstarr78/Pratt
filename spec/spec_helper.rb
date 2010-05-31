# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'rubygems'
require 'spec'
require 'mocha'
require 'lib/pratt'
require 'ruby-debug'

module SeedData
  def load_seed_data
    Customer.delete_all
    customer = Customer.create(
      :name         => 'Scott Noel-Hemming',
      :company_name => 'Frogstarr78 Software',
      :address      => '312 NW 7th',
      :phone        => '509.730.5401',
      :zip          => '97862'
    ) 

    Project.delete_all
    Project.create(
    [
      {
        :name => 'Refactor',
        :weight => 1,
        :customer => customer
      },
      {
        :name => 'Lunch/Break',
        :weight => 0,
        :customer => customer
      },
      {
        :name => 'Other',
        :weight => -1,
        :customer => customer
      }
    ]
    )
  end
end

Spec::Runner.configure do |config|
#  config.mock_with :rspec
  config.mock_with :mocha

  Pratt.connect! 'test'
end

shared_examples_for "Time spent on a project" do
end

shared_examples_for "being a billable item" do
  it "responds to amount" do
    subject.class.new.should respond_to(:amount) 
  end
end
