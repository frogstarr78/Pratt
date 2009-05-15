# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'spec'
PRATT_ENV = :test
require 'config'
require 'ruby-debug'

Spec::Runner.configure do |config|
  config.mock_with :rspec
end

shared_examples_for "Time spent on a project" do
  it "should correctly calculate time_spent with time argument" do
    when_to = Chronic.parse('monday this week')
    @project.start! when_to
    @project.stop!  when_to+3
    @project.time_spent.should == 3.0/3600
  end

  it "should correctly calculate time_spent with string time argument" do
    @project.start! 'last monday 12:00 pm'
    @project.stop!  'last monday 12:00:05 pm'
    @project.time_spent.should == 5.0/3600
  end
end

shared_examples_for "needing project instance that knows how to cleanup" do 
  before :each do
    @project = Project.primary
  end

  after :each do
    Project.all.collect(&:whences).collect(&:destroy_all)
  end
end
