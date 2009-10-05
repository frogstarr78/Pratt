require 'spec_helper'
require 'pratt'

describe Pratt do
  it "should act like an array" do
    @pratt = Pratt.new
    @pratt.expects(:todo).returns(@pratt.instance_variable_get("@todo"))
    @pratt.should respond_to(:<<)
    lambda {
      @pratt << :this
    }.should change(@pratt.todo, :size).by(1)
  end

  it "should start a new project when calling begin" do
    @project = mock('Refactor').expects(:start!)

    @pratt   = Pratt.new
    @pratt.project = @project

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
    Project.expects(:find_or_create_by_name).with( { :name => 'Refactor' } )
    @pratt.project = 'Refactor' 
  end

  describe "\b#root" do
    before :each do
      @expected_root = "/home/scott/git/pratt"
    end

    it "is correct without arguments" do
      Pratt.root.should == [Pathname.new(@expected_root)]
    end

    it "is correct with a block but no argument" do
      received = []
      Pratt.root {|model| received << model }
      received.should == [Pathname.new(@expected_root)]
    end

    it "is correct with an argument but no block" do
      Pratt.root('models').should == [Pathname.new(File.join(@expected_root, "models"))]
    end

    it "is correct with an argument and block" do
      received = []
      Pratt.root('models', '*.rb') {|model| received << model }
      received.to_set.should == %w(app.rb customer.rb log.rb project.rb payment.rb pratt.rb whence.rb).collect {|model| Pathname.new File.join(@expected_root, "models", model) }.to_set
    end
  end

  describe "graph" do
    before :each do
      @when_to = Chronic.parse('last week').beginning_of_week
      @pratt = Pratt.new
      @pratt.scale = :week
      @pratt.when_to = @when_to
    end

    def task name, time_spent
      task1 = Project.find_or_create_by_name :name => name
      task1.start! @when_to
      task1.stop! @when_to+time_spent
    end

    def populate_with_data
      Project.find_or_create_by_name :name => '**** ********', :weight => 1
      task 'Lunch/Break', 1.hour+21.minutes
      task 'Task1', 1.hour+4.minutes
      task 'Task2', 58.minutes
      task 'Another Task', 5.minutes
      task 'Task3', 1.day+17.hours+32.minutes
    end

    def get_expected_display
      File.open(Pratt.root('spec', 'fixtures', 'graph.expectation')).read
    end

    it "should look right with no data" do
      $orig_stdout = $stdout
      $stdout = StringIO.new ''
      $stdout.expects(:puts).with "No data to report" 
      @pratt.graph
      $stdout = $orig_stdout
    end

    it "should look right with data" do
      populate_with_data

#      @pratt.graph.should == get_expected_display
    end
  end
end
