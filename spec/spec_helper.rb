# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'spec'
require 'config'
require 'ruby-debug'

Spec::Runner.configure do |config|
#  config.mock_with :rspec
  config.mock_with :mocha

  Pratt.connect 'test'
end

shared_examples_for "Time spent on a project" do
  it "correctly calculates time_spent with time argument" do
    when_to = Chronic.parse('monday this week')
    @project.start! when_to
    @project.stop!  when_to+3
    @project.time_spent.should == 3.0/3600
  end

  it "correctly calculates time_spent with string time argument" do
    @project.start! 'last monday 12:00 pm'
    @project.stop!  'last monday 12:00:05 pm'
    @project.time_spent.should == 5.0/3600
  end

  it "correctly calculates time_spent with a scale" do
    whence = Chronic.parse('yesterday 11:53 pm')
    @project.start! whence
    @project.stop!  whence+17
    @project.time_spent('week').should == 17.0/3600
  end

  it "correctly calculates time_spent with a scale and specific time" do
    whence = Chronic.parse('yesterday 11:54 pm')
    @project.start! whence
    @project.stop!  whence+18
    @project.time_spent('day', Chronic.parse('yesterday')).should == 18.0/3600
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

shared_examples_for "being a billable item" do
  it "responds to amount" do
    subject.class.new.should respond_to(:amount) 
  end
end
