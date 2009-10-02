require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')

describe App do
  before :all do
    Pratt.connect :test
  end

  context "instances" do
    it "should only have one" do
      App.last.should_not be_nil
    end

    it "should have log" do
      @app = App.last
      @app.expects(:log).with('pop').returns(@app)
      @app.log 'pop'
    end

    it "should say it has something logged" do
      @app = App.new
      @app.gui?('main').should be_false
      @app.gui?('pop').should be_false

      @app.gui = 'main'
      @app.gui?('main').should be_true

      @app.gui = 'pop'
      @app.gui?('main').should be_false

      @app.gui = 'pop'
      @app.gui?('pop').should be_true

      @app.gui = 'pop'
      @app.gui?('bob').should be_false
    end

    it "should remove the gui when expected" do
      @app = App.create :gui => 'pop'
      
      @app.gui?('pop').should be_true
      @app.unlock
      @app.gui?('pop').should be_false

      @app.gui = 'main'
      @app.save
      @app.gui?('pop').should be_false
      @app.gui?('main').should be_true

      @app.destroy
    end
  end
end
