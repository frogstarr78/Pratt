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

require 'lib/pratt/core_ext'
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
  @@color = true

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

  # Singleton Accessor for @app
  def app
    @app ||= App.last
    @app
  end

  def console options = []
    require 'irb'
    require 'irb/completion'
    ARGV.clear
    IRB.start
  end

  def begin
    self.project.start! when_to
  end
  def restart
    if project?
      project.restart! when_to
    else
      Whence.last_unended.project.restart! when_to
    end
  end
  def end
    if project?
      project.stop! when_to
    else
      Whence.last_unended.stop! when_to
    end
  end
  def change
    Whence.last.change! project.name
  end
  def destroy
    project.destroy
  end
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

  def gui
    if Whence.last_unended
      pop
    else
      main
    end
  end

  def detect
    if self.daemonized?
      gui
    else
      daemonize!
    end
  end

  def unlock
    self.app.unlock
  end

  def run
    self.when_to.week_day_start = self.week_day_start

    self.begin      if i_should? :begin
    self.change     if i_should? :change
    self.restart    if i_should? :restart
    self.end        if i_should? :end

    self.destroy    if i_should? :destroy

    self.pid        if i_should? :pid
    self.raw        if i_should? :raw
    self.current    if i_should? :current
    self.graph      if i_should? :graph
    self.invoice    if i_should? :invoice
    self.console    if i_should? :console
    self.gui        if i_should? :gui
    self.detect     if i_should? :detect
    self.unlock     if i_should? :unlock

    self.quit       if i_should? :quit
    self.daemonize! if i_should? :daemonize and not self.daemonized?
  end

  def daemonized?
    !app.pid.blank? and ( cpid.to_i == app.pid )
  end
  def daemonize!
    defork { 
      puts "pratt (#{Process.pid.to_s.yellow})"
      app.pid = Process.pid
      app.save!

      gui
      while(daemonized?)
        sleep(app.interval)
        gui
      end
      quit
    }
  end

  private
    def reload_and_detect_lock of
      self.app.reload
      return if self.app.gui? of
      self.app.log of
    end

    def main
      reload_and_detect_lock 'main'
      projects = ([Project.primary, Project.off] | Project.rest).collect(&:name)
      if Whence.count == 0 
        # first run
        project = Whence.new(:project => Project.new)
        current_project_name = project.project.name
      else
        project = Whence.last_unended || Whence.last
        current_project_name = ''
      end

      if Project.count > 0
        projects = ([Project.primary, Project.off] | Project.rest).compact.collect(&:name)
      else
        projects = []
      end
      defork { 
        command = "ruby views/main.rb  --projects '#{projects*"','"}' --current '#{current_project_name}'"
        system command
      } 
    end

    def pop
      reload_and_detect_lock 'pop'
      self.project = Whence.last_unended.project
      defork do
        command = "ruby views/pop.rb  --project '#{project.name}' --start '#{project.whences.last_unended.start_at}' --project_time '#{Pratt.totals(project.time_spent)}'"
        system command
      end
    end

    def defork &block
      Process.detach(
        fork &block 
      )
    end


    def i_should? what
      @todo.include?(what)
    end

    def project?
      !@project.nil? and @project.name?
    end

    def process_template!
      input = File.open(Pratt.root("views", "#{template}.eruby").first).read
      erubis = Erubis::Eruby.new(input)
      puts erubis.evaluate(self)
    end

    def padded_to_max string
      self.class.padded_to_max string
    end

  class << self


    def color
      @@color
    end

    def color= c
      @@color = c
    end

    def color?
      @@color == true
    end


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

    # Calculate totals. I think this should be an instance method on Projects/?/Whences
    def totals hr, fmt = false
      "#{fmt_i(hr / 24, 'day', :cyan)} #{fmt_i(hr % 24, 'hour', :yellow)} #{fmt_i((60*(hr -= hr.to_i)), 'min', :green)}"
    end

    def fmt_i int, label, color
      "%s #{label}"% [("%02i"% int).send(color), label]
    end

    def percent label, off, total, color
      percent = "%0.2f"% ((off/total)*100)
      padded_to_max(label) << " #{percent}%".send(color)
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

    # Pad the output string to the maximum Project name
    def padded_to_max string
      project_padding = Project.longest_length_project
      "%#{project_padding}.#{project_padding}s"% string
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
