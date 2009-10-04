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
      received.to_set.should == %w(app.rb customer.rb log.rb project.rb whence.rb pratt.rb).collect {|model| Pathname.new File.join(@expected_root, "models", model) }.to_set
    end
  end
end
