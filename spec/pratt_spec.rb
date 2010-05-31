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
      @expected_root = File.dirname( File.expand_path( '..', __FILE__ ) ).to_s
      Dir.stubs(:pwd).returns(@expected_root)
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
      expected = %w(app.rb customer.rb project.rb payment.rb pratt.rb whence.rb invoice.rb invoice_whence.rb zip.rb)
      Pratt.root('models', '*.rb') {|model| received << model }
      received.to_set.should == expected.collect {|model| Pathname.new File.join(@expected_root, "models", model) }.to_set
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

    it "inits an irb console when given console argument" do
      Pratt.any_instance.stubs(:i_should?).returns false
      # ^ to bypass actually calling the code
      Pratt.any_instance.expects(:<<).with(:console)
      Pratt.parse %w(console)
    end
  end

  it "should start IRB when console method is called" do
    ARGV.expects(:clear)
    IRB.expects(:start)
    @pratt.console
  end
end
