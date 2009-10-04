require 'spec_helper'

describe Project do
  it_should_behave_like "needing project instance that knows how to cleanup"
  it_should_behave_like "Time spent on a project"

  context "scopes" do
    it "named primary" do 
      Project.primary.name.should == 'Home Refactor'  
    end

    it "named off" do 
      Project.off.name.should == 'Lunch/Break'  
    end

    it "named rest" do 
      Project.rest.size > 0
      Project.rest.collect(&:name).should_not include(Project.primary.name, Project.off.name)
    end

    it "named named" do
      Project.named('Home Refactor').name.should == 'Home Refactor'  
      Project.named('Lunch/Break').name.should   == 'Lunch/Break'  
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
  end
end
