# coding: utf-8
require 'fileutils'
require 'optparse'
require 'pathname'

require 'rubygems'
require 'colored'
require 'chronic'
require 'active_record'
require 'erubis'
require 'hoe'
require 'mocha'
require 'config'
require 'shifty_week'
require 'shifty_week/time'
require 'shifty_week/date'

require 'lib/pratt/formatting'
require 'lib/pratt/core_ext'
require 'lib/pratt/dialogs'
require 'lib/pratt/project_actions'
require 'lib/pratt/reports'
require 'lib/models'


class Pratt

  NAME         = 'Pratt'
  URL          = 'http://www.frogstarr78.com/projects/pratt'
  AUTHORS      = ['Scott Noel-Hemming']
  SUMMARY      = "Pro/Re-Active Time Tracker.  Track time based on what you expect to be working on, with frequent prompts to ensure accuracy."
  DESCRIPTION  = %q|
	  Need a way to keep track of your time, but get caught up in work? Or constant interruptions?
	  Yeah you know who I'm talking about. Those people from the [abc] department always "NEEDING xyz FEATURE NOW!!!".
	  Seriously though. I'm usually just loose track of time. I wanted an app that I could start with a task I think 
	  I'll be working on, but that get's in my face constantly to ensure I'm still working on it. And if I'm not any longer,
	  provides an easy way of changing to another task, or if I have changed tasks and not already updated the app, would 
	  provide an easy way of changing the task of the previously recorded interval. That's what this is intended to do.

	  Time Tracking.
	  Proactively set what you expect to work on.
	  Reactively modify what you are no longer working on.
  |
  DEPENDENCIES = ["activerecord >=2.1.1", "sqlite3-ruby >=1.2.4", "rspec >=1.2.6", "mocha >=0.9.5"]
  VERSION      = File.open( File.join(Dir.pwd, 'VERSION') ).read.strip

  PID_FILE='pratt.pid'
  FMT = "%a %X %b %d %Y"
  INVOICE_FMT = "%x"

  attr_accessor :when_to, :scale, :color, :show_all, :raw_conditions, :template, :week_day_start
  attr_reader :project, :todo
  def initialize proj = nil
    @when_to        = DateTime.now
    @week           = false
    @day            = false
    @todo           = []
    @scale          = nil
    @show_all       = false
    @template       = nil
    @raw_conditions = ''
    self.project = proj unless proj.nil?
  end

  # Set the project to something (Project/String)
  # Conditionally creating a new project if the project
  # named by the parameter isn't found
  def project= proj
    if proj.is_a?(Project)
      @project = proj
    else
      @project = Project.find_or_create_by_name( { :name => proj } )
    end
  end

  # We should act like an array
  def << what
    @todo << what
  end

  # Connect to the database in irb for manual commands/investigation
  def console options = []
    require 'irb'
    require 'irb/completion'
    ARGV.clear
    IRB.start
  end

  # Stop everything and kill daemonized processes.
  def quit
    project.stop! if project? and project.whences.last_unended
    Whence.last_unended.stop! if Whence.last_unended
    begin
      Process.kill("KILL", app.pid.to_i)
    rescue Errno::ESRCH
      puts "Unable to kill Pratt@pid(#{app.pid})."
    end
    app.pid = ''
    app.gui = ''
    app.save!
  end

  # Singleton Accessor for @app
  def app
    @app ||= App.last
    @app
  end

  # "Unlock" the gui. 
  def unlock
    self.app.unlock
  end

  def run
    # ensure we've shifted the when_to value to the 
    # current start of week
    self.when_to.week_day_start = self.week_day_start

    # << order is semi important
    self.end         if i_should? :end
    self.begin       if i_should? :begin
    self.change      if i_should? :change
    self.restart     if i_should? :restart

    self.destroy     if i_should? :destroy
    # end order is semi important

    # << order doesn't matter within this set
    self.pid         if i_should? :pid
    self.raw         if i_should? :raw
    self.current     if i_should? :current
    self.graph       if i_should? :graph
    self.proportions if i_should? :proportions
    self.invoice     if i_should? :invoice
    self.console     if i_should? :console
    self.gui         if i_should? :gui
    self.detect      if i_should? :detect
    self.unlock      if i_should? :unlock
    # end order doesn't matter within this set

    # << these should happen last
    self.quit        if i_should? :quit
    self.daemonize!  if i_should? :daemonize and not self.daemonized?
    # end these should happen last
  end

  private
    def i_should? what
      @todo.include?(what)
    end

    # Is there a project that can be operated on?
    def project?
      !@project.nil? and @project.name?
    end

  class << self

    # Parse cli arguments and init Pratt
    def parse args
      me = Pratt.new

      # There are aa few things we're parsing here
      # Pratt config arguments (Ideally that should be all we do)
      # Pratt actions. These may require ordering or not. They also may require an argument value.
      # 
      # TODO: Redo the cli parsing...
      # In some cases we require arguments to be run in a certain order, but we don't want some to be run concurrently w/ others.
      # Sometimes it may be unexpected but helpful to allow that behavior. 
      opt = OptionParser.new do |opt|
        Pratt.connect! ENV['PRATT_ENV'] || 'development' unless Pratt.connected?

          # Actionable options
        opt.on('-b', "--begin", String, "Begin project tracking.") do
          me << :begin
        end
        opt.on('-r', "--restart", String, "Restart project log (stop last log and start a new one).
                                       Applies to last un-ended project, unless a specific project is provided.") do
          me << :restart
        end
        opt.on('-e', "--end", String, "Stop tracking interval for last project or supplied project if provided.") do
          me << :end
        end
        opt.on('-c', "--change", String, "Change last time interval to this project.") do
          me << :change
        end
        opt.on('-g', "--graph", String, "Display time spent on supplied project or all projects without argument value.") do
          me << :graph
        end
        opt.on('-I', "--invoice", "Create an invoice.") do
          me << :invoice
        end
        opt.on('-r', '--proportions', "") do
          me << :proportions
        end
        opt.on('-p', '--pid', "Process id display. (Is it still running)") do
            me << :pid
        end
        opt.on('-R', '--raw [CONDITIONS]', "Dump logs (semi-)raw") do |conditions|
          me << :raw
          me.raw_conditions = conditions
        end
        opt.on('-C', "--current", "Show available projects and current project (if there is one)") do
          me << :current
        end
        opt.on("-d", "--daemonize", "Start daemon.") do
          me << :daemonize
        end
        opt.on('-D', '--detect', 'Detect appropriate behavior. (Daemonize or Graphical).') do
          me << :detect
        end
        opt.on('-G', '--gui', 'Show "smart" gui.') do
          me << :gui
        end
        opt.on('-q', "--quit", "Stop daemon.") do
          me << :quit
        end
        opt.on('-U', '--unlock', "Manually unlock a gui that has died but left it's lock around.") do
          me << :unlock
        end
        opt.on '-V', '--version' do
          puts "Pro-Reactive Time Tracker [Pratt] (#{VERSION})"
        end
        opt.on('--destroy', String, "Remove a project.") do
          me << :destroy
        end

        # Strictly configuration options
        project_names = Project.all.collect(&:name)
        colored_project_names = project_names.collect{|name| 
"                                        #{name.cyan}"}
        opt.on('-P', "--project PROJECT_NAME", project_names, "Set project.
                                      Available projects are:\n#{colored_project_names*"\n"}") do |proj|
          me.project = proj
        end

        templates = [] 
        Pratt.root("views", "*.eruby") {|view| templates << File.basename(view, '.eruby') }
        opt.on('-t', "--template TEMPLATE", templates, "Template to use for displaying work done.
                                       Available templates are #{templates.to_sentence('or')}.") do |template|
          me.template = template
        end
        opt.on '-w', '--when_to TIME', String, 'When to do something. 
                                       (e.g. log time start|stop, or what time interval to graph)
                                       If graphing, silently ignored w/out scale argument.' do |when_to|
          me.when_to = Chronic.parse(when_to).to_datetime
        end
        scales = %w(day week month quarter year)
        opt.on('-l', '--scale SCALE', scales, "Granularity of time argument
                                       Available scales are #{scales.to_sentence('or')}.
                                       Only applies to graphing.") do |scale|
          me.scale = scale
        end
        opt.on('-L', '--log', "Redirect errors") do
          FileUtils.mkdir 'log' unless File.exists? 'log'
          $stderr.reopen('log/pratt.log', 'a')
          $stderr.sync = true
        end
        opt.on('-N', '--no-color', "Display output without color or special characters.") do 
          Pratt.color = false
        end
        opt.on('-A', '--show-all', "Display all project regardless of other options.") do 
          me.show_all = true
        end
        opt.on '-s', '--start-day WEEK_DAY_START', String, "" do |wday_start|
          me.week_day_start = wday_start
        end
        opt.on('-i', "--interval INTERVAL", Float, "Set the remind interval/min (Only applies to daemonized process).") do |interval|
          me.app.interval = interval
          me.app.save
        end

        opt.parse!
      end

      me << :console if args.include? 'console'

      me.run
    end

    # Where is Pratt installed.
    # We've already chdir'd to it's base dir in the bin file
    def root *globs, &block
      root = Dir.pwd
      if globs.empty?
        subdir = root
      else
        subdir = File.join(root, *globs)
      end

      if block_given?
        Pathname.glob(subdir) {|dir_files| yield dir_files }
      else
        Pathname.glob(subdir)
      end
    end

    # Migrate schema.
    def migrate
      Pratt.root( 'models', '*.rb' ) do |model_file|
        klass = File.basename( model_file, '.rb' ).classify.constantize
        begin
          ActiveRecord::Base.connection.table_structure(model_file)
        rescue ActiveRecord::StatementInvalid
          klass.migrate :up if klass.superclass == ActiveRecord::Base
        end
      end
    end
  end
end
