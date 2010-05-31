require 'spec_helper'

# enable laziness
class Mocha::Mock
  def name
    @name.instance_variable_get("@name")
  end
end

describe Project do
  it_should_behave_like "being a billable item"

  it{ Project.should respond_to(:primary) }
  it{ Project.should respond_to(:off) }
  it{ Project.should respond_to(:rest) }
  it{ Project.should respond_to(:longest_project_name) }

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
    include SeedData

    before :each do
      load_seed_data
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
        Payment.create :rate => '315.0', :billable => @project

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
        @project.amount(@project.time_spent).should == 6*3.15
      end

      it "is correct with a scale" do
        @project.amount(@project.time_spent(:month)).should == 6*3.15
      end

      it "is correct with a scale and time" do
        @project.amount(@project.time_spent(:week, @now)).should == 3*3.15
      end
    end
  end

  context "time_spent" do
    before :each do
      @project = Project.new
    end

    it "correctly calculates with no data" do
      @project.expects(:time_spent).returns 0
      @project.time_spent.should == 0.0
    end

    it "correctly calculates with time argument" do
      now = Time.now.beginning_of_day
      Whence.expects(:find).returns [mock('whence1', :start_at => now, :end_at => now+=1.hour), mock('whence2', :start_at => now+=2.hours, :end_at => now+=2.hour+30.minutes)]
      @project.time_spent.should == 3.5
    end

    it "correctly calculates with string time argument" do
      whence = mock('whence', :start_at => Chronic.parse('last monday 12:00 pm'), :end_at => Chronic.parse('last monday 12:00:05 pm'))
      Whence.expects(:find).returns [whence]
      @project.time_spent.should == 5.0/3600
    end

    it "correctly calculates with a scale" do
      whence = mock('whence', :start_at => Time.parse('2009-10-04 23:53:32'), :end_at => Time.parse('2009-10-05 00:10:32'))
      Whence.expects(:find).returns [whence]
      @project.time_spent('month').should == 17.0/60
    end

    it "correctly calculates with a scale and specific time" do
      whence = mock('whence', :start_at => Time.parse('2009-10-05 23:54:32'), :end_at => Time.parse('2009-10-06 00:12:32'))
      Whence.expects(:find).returns [whence]
      @project.time_spent('day', Chronic.parse('yesterday')).should == 18.0/60
    end
  end

end
