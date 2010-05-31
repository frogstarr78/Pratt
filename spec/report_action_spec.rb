require 'spec_helper'
require 'pratt'

describe "Pratt report actions" do
  include SeedData

  before :each do
    @pratt = Pratt.new
    @when_to = DateTime.now
    load_seed_data
  end

  after :each do
    Whence.delete_all
  end

  it "calls project#start! in begin method" do
    @pratt.project = Project.primary
    @pratt.when_to = @when_to
    @pratt.project.expects(:start!).with @when_to
    @pratt.begin
  end

  it "calls project#restart! in restart method with defined project" do
    @next_when_to = @when_to + 7.minutes
    primary = Project.primary
    primary.start! @when_to
    @pratt.project = primary
    @pratt.when_to = @next_when_to
    whence = primary.whences.last
    Whence.expects(:last_unended).never
    primary.expects(:restart!).with @next_when_to
    @pratt.restart
  end

  it "calls last unended project in restart method without defined project" do
    @next_when_to = @when_to + 7.minutes
    primary = Project.primary
    primary.start! @when_to
    @pratt.when_to = @next_when_to
    whence = primary.whences.last
    Whence.expects(:last_unended).returns whence
    whence.project.expects(:restart!).with @next_when_to
    @pratt.restart
    whence.project.should eql(primary)
  end

  it "stops! defined project in end method" do
    @pratt.project = Project.primary
    @pratt.when_to = @when_to
    @pratt.project.expects(:stop!).with @when_to
    @pratt.end
  end

  it "stops! the last unended project in end method without defined project" do
    primary = Project.primary
    primary.start! @when_to
    whence = primary.whences.last
    Whence.expects(:last_unended).returns whence
    whence.expects(:stop!).with @when_to
    @pratt.when_to = @when_to
    @pratt.end
  end

  it "changes last project in change method" do
    primary = Project.primary
    primary.start! @when_to
    primary.stop! @when_to+10.minutes
    other = Project.rest.first
    whence = primary.whences.last
    Whence.expects(:last).returns whence
    whence.expects(:change!).with other.name
    @pratt.project = other
    @pratt.change
  end
  
  it "destroys defined project in destroy method" do
    @pratt.project = Project.create :name => "to be destroyed"
    lambda {
      @pratt.destroy
    }.should change(Project, :count).by -1
  end
end
