require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')
require 'pratt'

describe Pratt do

  before :all do
    Pratt.connect :test
  end

  it "should act like an array" do
    @pratt = Pratt.new
    @pratt.should respond_to(:<<)
    lambda {
      @pratt << :this
    }.should change(@pratt.todo, :size).by(1)
  end

  it "should start a new project when calling begin" do
    @project = mock('Home Refactor')
    @project.stub!(:start!)

    @pratt   = Pratt.new
    @pratt.project = @project

    @pratt.project.should_receive(:"start!").once
    @pratt.begin
  end

  it "should allow project to be set by object" do
    @pratt = Pratt.new
    @pratt.should_receive(:project=).with(Project.refactor).at_least(:once).and_return(Project.refactor)
    @pratt.project = Project.refactor 
  end

  it "should allow project to be set by a string" do
    @pratt = Pratt.new
#    @project_class = Project
#    @project_class.stub!(:find_or_create_by_name)
    @pratt.should_receive(:project=).with('Home Refactor').at_least(:once).and_return(Project.refactor)
    @pratt.project = 'Home Refactor' 
    Project.should_receive(:find_or_create_by_name)#.with( { :name => 'Home Refactor' } ).and_return(Project.refactor)
  end

#  it "ought to error when not given a name" do
#    @pratt = Pratt.new('Home Refactor')
##    @pratt.stub!(:project)
#
#    @pratt.should_receive(:project=).at_least(:once).and_return(Project.refactor)
#    @pratt.project= 'Home Refactor'
#
##    project.should_receive(:find_or_create_by_name).with( { :name => 'Home Refactor' } ).and_return(Project.refactor)
##    proj.should_receive(:start!).with(1, kind_of(DateTime), "at") do |arg|
##      puts arg.inspect
##      arg.should be_an_instance_of(DateTime)
##      arg.length.should == 1
##    end
#
##    p = Project.new(:name => 'Something').start!
##    p.should be_invalid
#  end

#  context "when it's begun" do
#    it "ought to create a new whence log with a nil end_at time" do
#      p = Project.new(:name => 'Something').start!
#      p.should.
#    end
#  end
end
