require 'spec_helper'
require 'pratt'

describe "Pratt report methods" do
  before :each do
    @pratt = Pratt.new
  end

  describe "graph" do
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
      task = Project.find_or_create_by_name :name => name, :customer => @customer
      task.start! @when_to
      task.stop! @when_to+time_spent
      @tasks << task
    end

    def populate_with_data
      @tasks << Project.find_or_create_by_name( :name => '**** ********', :weight => 1, :customer => @customer )
      task 'Lunch/Break', 1.hour+21.minutes
      task 'Task1', 1.hour+4.minutes
      task 'Task2', 58.minutes
      task 'Another Task', 5.minutes
      task 'Task3', 1.day+17.hours+32.minutes
    end

    def get_expected_display
      e = ''
      Pratt.root('spec', 'fixtures', 'graph.expectation') {|file| e = File.open(file).read }
      e
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
end
