require 'spec_helper'

describe Whence do
  it_should_behave_like "needing project instance that knows how to cleanup"
  it_should_behave_like "Time spent on a project"

  context "scopes" do

    after :each do
      Project.all.collect(&:whences).collect(&:destroy_all)
    end

    it "last_unended should return nil if there aren't any unended" do
      lambda {
        Project.primary.start!
        Project.primary.stop! Time.now+2
      }.should change(Whence, :count).by(1)
      Whence.last_unended.should be_nil 
    end

    it "last_unended should only return the very last one" do
      lambda {
        Project.primary.start!
        Project.primary.start! Time.now+2
      }.should change(Whence, :count).by(2)
      Whence.last_unended.should be_kind_of(Whence) 
      whences = Project.primary.whences.all(:conditions => "end_at IS NULL", :order => "id ASC")
       
      Whence.last_unended.should eql(whences.last)
      Whence.last_unended.should_not eql(whences.first)
    end
  end

  context "instances" do

    it "should correctly log entries using stop!" do 
      @project.start! Time.now
    
      when_to = Time.now+2
      lambda {
        @project.stop! when_to
      }.should_not change(@project.whences.last, :end_at).to(when_to)
      @project.should be_valid
    end

    it "should change! to project correctly" do
      @project.start!
      @project.stop! Time.now+2
      Whence.last.change!('Lunch/Break')
      Whence.last.project.name.should == 'Lunch/Break'
    end

    it "should have a special output for start_at.to_s" do
      when_to = Time.now+12
      @project.start! when_to
      Whence.last_unended.start_at.to_s.should eql(when_to.strftime("%a %d %b %Y %X"))
    end
  end
end
