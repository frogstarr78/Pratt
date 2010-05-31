require 'spec_helper'
require 'pratt'

describe "Pratt report method" do
  before :each do
    @pratt = Pratt.new
  end

  describe "#graph" do
    it "with no project uses Project.all to generate output" do
      @pratt.expects(:template=).with("graph")
      @pratt.expects(:project?).returns false
      Project.expects(:all).returns([])
      @pratt.expects(:process_template!)
      @pratt.graph
    end

    it "with project uses defined project to generate output" do
      @pratt.project = Project.new
      @pratt.expects(:template=).with("graph")
      @pratt.expects(:project?).returns true
      @pratt.expects(:process_template!)
      @pratt.graph
      @pratt.instance_variable_get("@projects").should eql([@pratt.project])
    end
  end

  describe "output" do
    include SeedData
    before :each do
      @when_to = Chronic.parse('September 29 2009').beginning_of_week
      @pratt.scale = 'week'
      @pratt.when_to = @when_to
      @customer = Customer.create :name => 'Bob Hope', :address => '123 Where St', :zip => '22222'
      @tasks = []
    end

    after :each do
      Whence.delete_all
      @customer.destroy
      @tasks.each(&:destroy)
    end

    def get_expected_display fixture_name
      Pratt.root('spec', 'fixtures', "#{fixture_name}.expectation").first.read
    end

    it "graphs output as expected with no data" do
      Pratt.color = false
      Project.stubs(:longest_project_name).returns 12
      Project.stubs(:all).returns([])
      $stdout.expects(:puts)
      @pratt.graph
      @pratt.send(:output).should eql( get_expected_display("empty_graph") )
    end

    it "graphs output as expected with data" do
      populate_with_data
      Pratt.color = false
      Project.stubs(:longest_project_name).returns 12
      $stdout.expects(:puts)

      @pratt.graph
      @pratt.send(:output).should eql( get_expected_display("graph") )
    end

    it "generates proportions graphs output as expected with data" do
      populate_with_data
      Pratt.color = false
      Project.stubs(:longest_project_name).returns 12
      $stdout.expects(:puts)

      @pratt.proportions
      @pratt.send(:output).should eql( get_expected_display("proportions") )
    end

    def task name, time_spent
      task = Project.find_or_create_by_name :name => name, :customer => @customer
      task.start! @when_to
      task.stop! @when_to+time_spent
      @tasks << task
    end

    def populate_with_data
      load_seed_data
      @tasks << Project.primary
      task 'Lunch/Break', 1.hour+21.minutes+0.seconds
      task 'Task1', 1.hour+4.minutes+0.seconds
      task 'Task2', 58.minutes+0.seconds
      task 'Another Task', 5.minutes+0.seconds
      task 'Task3', 1.day+17.hours+32.minutes+0.seconds
    end
  end

  describe "#proportions" do
    include SeedData
    before :each do
      @when_to = Chronic.parse('last week').beginning_of_week
      @pratt.scale = 'week'
      @pratt.when_to = @when_to
      @customer = Customer.create :name => 'Bob Hope', :address => '123 Where St', :zip => '22222'
      @tasks = []
    end

    after :each do
      Whence.delete_all
      @customer.destroy
      @tasks.each(&:destroy)
    end

    def task name, time_spent
      task = Project.find_or_create_by_name :name => name, :customer => @customer, :weight => -1
      task.start! @when_to
      task.stop! @when_to+time_spent
      @tasks << task
    end

    def populate_with_data
      load_seed_data
      primary = Project.primary
      primary.start! @when_to
      primary.stop! @when_to+20.hours
      @tasks << primary
      task 'Lunch/Break', 1.hour+21.minutes
      task 'Task1', 1.hour+4.minutes
      task 'Task2', 58.minutes
      task 'Another Task', 5.minutes
      task 'Task3', 1.day+17.hours+32.minutes
    end

    it "uses Project.all with data to generate output" do
      populate_with_data
      @pratt.expects(:template=).with("proportions")
      @pratt.expects(:project?).returns false
      @pratt.expects(:process_template!)
      @pratt.proportions
      @pratt.instance_variable_get("@primary").should eql(20.0)
      @pratt.instance_variable_get("@off_total").should eql(1.35)
      @pratt.instance_variable_get("@rest_total").should eql(43.65)
      @pratt.instance_variable_get("@projects").should eql(Project.all)
      @pratt.instance_variable_get("@scaled_total").should eql(63.65)
    end

    it "uses defined project with data to generate output" do
      populate_with_data
      @pratt.expects(:template=).with("proportions")
      @pratt.expects(:project?).returns true
      @pratt.project = Project.named('Task1')
      @pratt.expects(:process_template!)
      @pratt.proportions
      @pratt.instance_variable_get("@primary").should eql(64/60.0)
      @pratt.instance_variable_get("@off_total").should eql(0.0)
      @pratt.instance_variable_get("@rest_total").should eql(0.0)
      @pratt.instance_variable_get("@projects").should eql([@pratt.project])
      @pratt.instance_variable_get("@scaled_total").should eql(64/60.0)
    end

    it "uses Project.all with no data to generate output" do
      @pratt.expects(:template=).with("proportions")
      @pratt.expects(:project?).returns false
      Project.expects(:all).returns []
      @pratt.expects(:process_template!).never
      $stdout.expects(:puts).with "No data to report"
      @pratt.proportions
    end

    it "uses defined project with no with data to generate output" do
      @pratt.expects(:template=).with("proportions")
      @pratt.expects(:project?).returns true
      @pratt.project = Project.new
      @pratt.project.expects(:time_spent).twice.returns 0.0
      @pratt.expects(:process_template!).never
      $stdout.expects(:puts).with "No data to report"
      @pratt.proportions
      @pratt.instance_variable_get("@primary").should eql(0.0)
      @pratt.instance_variable_get("@off_total").should eql(0.0)
      @pratt.instance_variable_get("@rest_total").should eql(0.0)
      @pratt.instance_variable_get("@projects").should eql([@pratt.project])
      @pratt.instance_variable_get("@scaled_total").should eql(0.0)
    end
  end
end
