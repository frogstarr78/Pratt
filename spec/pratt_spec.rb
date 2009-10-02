require 'spec_helper'
require 'pratt'

describe Pratt do

  before :all do
    Pratt.connect :test
  end

  it "should act like an array" do
    @pratt = Pratt.new
    @pratt.expects(:todo).returns(@pratt.instance_variable_get("@todo"))
    @pratt.should respond_to(:<<)
    lambda {
      @pratt << :this
    }.should change(@pratt.todo, :size).by(1)
  end

  it "should start a new project when calling begin" do
    @project = mock('Home Refactor')

    @pratt   = Pratt.new
    @pratt.project = @project

    @pratt.project.expects(:"start!")
    @pratt.begin
  end

  it "should allow project to be set by object" do
    @pratt = Pratt.new
    Project.expects(:find_or_create_by_name).never
    @pratt.project = Project.primary 
    @pratt.project.should == Project.primary
  end

  it "should allow project to be set by a string" do
    @pratt = Pratt.new
    Project.expects(:find_or_create_by_name).with( { :name => 'Home Refactor' } )
    @pratt.project = 'Home Refactor' 
  end

#  it "ought to error when not given a name" do
#    @pratt = Pratt.new('Home Refactor')
##    @pratt.stub!(:project)
#
#    @pratt.should_receive(:project=).at_least(:once).and_return(Project.primary)
#    @pratt.project= 'Home Refactor'
#
##    project.should_receive(:find_or_create_by_name).with( { :name => 'Home Refactor' } ).and_return(Project.primary)
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
