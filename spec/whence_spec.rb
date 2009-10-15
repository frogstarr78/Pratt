require 'spec_helper'

describe Whence do

  context "scopes" do
    it "last_unended should return nil if there aren't any unended" do
      Whence.expects(:first).with(:conditions => "end_at IS NULL", :order => "start_at DESC")
      Whence.last_unended
    end
  end

  context "instances" do
    before :each do
      @whence = Whence.new
    end

    it "parse a string argument to stop!" do
      when_to = 'yesterday'
      when_to = '2009-10-06 13:48:58'
      expectation = Chronic.parse when_to

      @whence.expects(:save!)
      @whence.expects(:reload)
      # don't work I'm not sure why
      # @whence.expects(:end_at).with expectation
      # Chronic.expects(:parse).with when_to

      @whence.stop! when_to
      @whence.end_at.should == expectation
    end

    it "doesn't parse a non-string thing on stop!" do
      when_to = Chronic.parse 'last week'
      Chronic.expects(:parse).never
      @whence.expects(:save!)
      @whence.expects(:reload)
      @whence.stop! when_to
      @whence.end_at.should == when_to
    end

    it "should change! to project correctly" do
      project_name = 'proj'
      @whence.expects(:save!)
      @whence.expects(:reload)
      @whence.change! project_name
      @whence.project.name.should == project_name
    end

    it "should have a special output for start_at.to_s" do
      @whence.start_at = Time.parse('Wed Oct 7 10:57:21 PDT 2009')
      @whence.start_at.to_s.should eql('Wed 07 Oct 2009 10:57:21') 
    end
  end
end
