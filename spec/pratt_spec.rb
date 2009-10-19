require 'spec_helper'
require 'pratt'

describe Pratt do
  before :each do
    @pratt = Pratt.new
  end

  it "should act like an array" do
    @pratt.should respond_to(:<<)
    lambda {
      @pratt << :this
    }.should change(@pratt.todo, :size).by(1)
    @pratt.todo.should == [:this]
  end

  it "correctly report i_should?" do
    @pratt.send(:i_should?, :this).should be_false
    @pratt << :this
    @pratt.send(:i_should?, :this).should be_true
  end

  it "should start a new project when calling begin" do
    @pratt.project = mock('Refactor')
    @pratt.when_to = Time.now
    @pratt.project.expects(:start!).with(@pratt.when_to)

    @pratt.begin
  end

  it "should allow project to be set by object" do
    primary = Project.new :name => 'project', :weight => 1
    Project.expects(:find_or_create_by_name).never
    @pratt.project = primary 
    @pratt.project.should == primary
  end

  it "should allow project to be set by a string" do
    Project.expects(:find_or_create_by_name).with( { :name => 'Refactor' } )
    @pratt.project = 'Refactor' 
  end

  describe "color" do

    it "should color when expected" do
      Pratt.color = true
      'this'.red.should == 'this'.red
    end

    it "should not color when not expected" do
      Pratt.color = false
      'this'.red.should == 'this'
    end
  end

  describe "\b#root" do
    before :each do
      Dir.stubs(:pwd).returns("/home/scott/git/pratt")
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
      received.to_set.should == %w(app.rb customer.rb project.rb payment.rb pratt.rb whence.rb).collect {|model| Pathname.new File.join(@expected_root, "models", model) }.to_set
    end
  end

  describe "graph" do
    before :each do
      @when_to = Chronic.parse('last week').beginning_of_week
      @pratt.scale = 'week'
      @pratt.when_to = @when_to
    end

    after :each do
      Whence.delete_all
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
      Pratt.root('spec', 'fixtures', 'graph.expectation') {|file| File.open(file).read }
    end

    it "report no data" do
      Project.expects(:all).returns([])
      @pratt.expects(:process_template!).never
      @pratt.graph.should == "No data to report"
    end

    it "should look right with data" do
      populate_with_data
      @pratt.expects(:process_template!)

      @pratt.graph.should == get_expected_display
    end
  end

  describe "parse" do
    it "handles cli arg -n setting appropriate environment config"
#    do
##      Pratt.expects(:connect).with('staging')
##      lambda {
#        Pratt.parse %w(--env staging)
##      }.should change(ENV['PRATT_ENV']).from('test').to('staging')
#      ENV['PRATT_ENV'].should == 'staging'
#    end

#    it "inits an irb console when given console argument" do
#      Pratt.any_instance.stubs(:i_should?).returns false
#      # ^ to bypass actually calling exec
#      # :i_should? and Pratt#run should be 
#      # tested independently and we don't
#      # need to test exec
#      Pratt.any_instance.expects(:<<).with(:console)
#      Pratt.parse %w(console)
#    end
  end
end
