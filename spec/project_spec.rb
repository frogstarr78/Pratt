require 'spec_helper'

# enable laziness
class Mocha::Mock
  def name
    @name.instance_variable_get("@name")
  end
end

describe Project do
  it_should_behave_like "being a billable item"

  context "scopes" do
    it "named primary" do 
      Project.expects(:first).with(:conditions => { :weight => 1 }).returns(mock('Refactor'))
      Project.primary.name.should == 'Refactor'  
    end

    it "named off" do 
      Project.expects(:first).with(:conditions => { :name => 'Lunch/Break' }).returns(mock('Lunch/Break'))
      Project.off.name.should == 'Lunch/Break'  
    end

    it "named rest" do 
      prim = mock('Refactor')
      off  = mock('Lunch/Break')
      other = mock('Other')

      Project.expects(:primary).returns prim
      Project.expects(:off).returns off
      Project.expects(:all).returns([prim, off, other])
      Project.rest.should == [other]
    end

    it "named named" do
      Project.expects(:first).with(:conditions => { :name => 'Refactor' }).returns(mock('Refactor'))
      Project.named('Refactor').name.should == 'Refactor'  
      
      Project.expects(:named).with(nil).returns nil
      Project.named(nil).should be_nil  
    end
  end

  context "instances" do
    before :each do
      @project = Project.primary
      @log_count = @project.whences.size
    end

    after :each do
      @project.whences.destroy_all
    end

    it "should correctly log entries using start! and stop!" do 
      lambda {
        @project.start!
      }.should change(@project.whences, :count).by(1)
      @project.whences.last.end_at.should be_nil

      sleep 1
      lambda {
        @project.stop!
      }.should_not change(@project.whences, :count)
      @project.should be_valid
      @project.whences.reload
      @project.whences.last.end_at.should > @project.whences.last.start_at
    end

    it "should log correct time if given (not the default)" do
      lambda {
        @project.start!
      }.should change(@project.whences, :count).by(1)
      @project.whences.last.end_at.should be_nil
    end

    it "should do nothing if attempting to stop a project that hasn't been started" do
      lambda {
        @project.stop!
      }.should_not change(@project.whences, :count)
    end

    it "should stop! then start! when calling restart!" do
      @project.start!
      first_started_id = @project.whences.last.id

      lambda {
        @project.restart!
      }.should change(@project.whences, :count).by(1)
      @project.whences.last.end_at.should be_nil
      @project.whences.last.id.should_not == first_started_id
    end

    it "has a customer association" do
      @project.should respond_to(:customer) 
    end

    context "amount calculation" do
      before :each do
        Payment.create :rate => '315', :billable => @project

        @now = Time.parse("2009-10-04 17:53:58")
        Time.stubs(:now).returns(@now.beginning_of_week)

        whence = Time.now-1.day
        @project.start! whence
        @project.stop!  whence+3.hours

        whence = Time.now
        @project.start! whence
        @project.stop!  whence+3.hours

        @project.reload
      end

      it "is correct with no arguments" do
        @project.amount.should == 6*3.15
      end

      it "is correct with a scale" do
        @project.amount(:month).should == 6*3.15
      end

      it "is correct with a scale and time" do
        @project.amount(:week, @now).should == 3*3.15
      end
    end
  end

  context "time_spent" do
    it "correctly calculates with time argument" do
      whence = mock('whence', :start_at => '2009-10-05 00:08:32', :end_at => '2009-10-05 3:08:32')
      Whence.expects(:find).with(:all).returns whence
      project = Project.new
#      project.expects(:whences).returns(whence)
      project.time_spent.should == 3.0/3600
    end

    it "correctly calculates with string time argument" do
      @project.start! 'last monday 12:00 pm'
      @project.stop!  'last monday 12:00:05 pm'
      @project.time_spent.should == 5.0/3600
    end

    it "correctly calculates with a scale" do
      whence = Chronic.parse('yesterday 11:53 pm')
      @project.start! whence
      @project.stop!  whence+17
      @project.time_spent('week').should == 17.0/3600
    end

    it "correctly calculates with a scale and specific time" do
      whence = Chronic.parse('yesterday 11:54 pm')
      @project.start! whence
      @project.stop!  whence+18
      @project.time_spent('day', Chronic.parse('yesterday')).should == 18.0/3600
    end
  end
end
