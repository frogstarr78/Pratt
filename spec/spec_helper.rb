# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'spec'
require 'config'
require 'ruby-debug'

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
