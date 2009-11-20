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

require 'lib/pratt/array'
require 'lib/pratt/string'
require 'lib/pratt/time'

require 'models/app'
require 'models/customer'
require 'models/whence'
require 'models/project'
require 'models/payment'

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

  attr_accessor :when_to, :scale, :color, :show_all, :env, :raw_conditions, :template, :week_day_start
  attr_reader :project, :todo
  def initialize proj = nil
    @when_to        = DateTime.now
    @week           = false
    @day            = false
    @todo           = []
    @scale          = nil
    @show_all       = false
    @template       = nil
    @env            = :development
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

  # TODO Rename
  def graph
    @primary = @off_total = @rest_total = 0.0
    self.template = 'graph'

    if project?
      @projects = [project]

      @primary = project.time_spent(scale, when_to)
      @scaled_total = project.whences.time_spent(scale, when_to)
    else
      @projects = Project.all

      @projects.each do |proj| 
        @primary     = proj.time_spent(scale, when_to) if proj.name == Project.primary.name
        @off_total   = proj.time_spent(scale, when_to) if proj.name == Project.off.name
        @rest_total += proj.time_spent(scale, when_to) if Project.rest.collect(&:name).include?(proj.name)
      end
      @scaled_total = Whence.time_spent(scale, when_to)-@off_total
    end

    if @primary + @off_total + @rest_total > 0.0
      process_template!
    else
      "No data to report"
    end
  end

  # Generate an invoice for a given time period
  def invoice
    self.template = 'invoice'

    if project?
      @projects = [project]

      @total = project.time_spent(scale, when_to)
    else
      @projects = (Project.all - [Project.primary, Project.off])
      @projects.select! {|proj| show_all or ( !show_all and proj.time_spent(scale, when_to) != 0.0 ) }

      @total = @projects.inject 0.0 do |total, proj| 
        total += proj.time_spent(scale, when_to)
        total
      end
    end

    @projects.each do |project| 
      puts "#{project.name} #{project.payment.inspect}"
    end
    if @total > 0.0
      puts process_template!
    else
      puts "No data to report"
    end
  end

  def console options = []
    options << %w(-r\ irb/completion -r\ lib/pratt --simple-prompt)
    exec "irb #{options.join ' '}"
  end

  def current
    project_names = ([Project.primary, Project.off] | Project.rest).collect(&:name)

    if last_whence = Whence.last_unended || Whence.last
      puts "   projects: " << (
        project_names.collect {|project_name| "'#{project_name.send(last_whence.end_at.nil? && last_whence.project.name == project_name ? :green : :magenta)}'" }
      ) * ' '
      if last_whence.end_at.nil?
        puts "    started: #{last_whence.start_at.strftime(FMT).send(:blue)}"
        time_til = ( app.interval - ( Time.now - last_whence.start_at ) )
        puts "next prompt: %s %s"% [Pratt.fmt_i( time_til / 60.0, 'min', :yellow ), Pratt.fmt_i( time_til % 60, 'sec', :yellow ) ], ''
      end
    else
      puts "   projects: " << (
        project_names.collect do |project_name| 
          "'#{project_name.magenta}'" 
        end
      ) * ' '
    end
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

  def cpid
    `pgrep -fl 'bin/pratt'`.chomp.split(' ').first
  end

  def pid
    self.template = 'pid'
    puts process_template!
  end

  def raw
    self.template = 'raw'

    if project = Project.find_by_name( raw_conditions )
      @whences = project.whences.all
    else
      case raw_conditions
        when 'all'
          @whences = Whence.find raw_conditions.to_sym
        when /^last$/, 'first'
          @whences = [Whence.find raw_conditions.to_sym]
        when /last[\(\s]?(\d+)[\)\s]?/
          @whences = Whence.all.last($1.to_i)
        else
          @whences = Whence.all :conditions => ["start_at > ?", Chronic.parse("today 00:00")]
      end
    end
    @whences.sort_by(&:id)
    puts process_template!
  end

  def quit
    project.stop! if project? and project.whences.last_unended
    Whence.last_unended.stop! if Whence.last_unended
    begin
      Process.kill("KILL", app.pid.to_i)
    rescue Errno::ESRCH
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

  def show_env
    defork { system("ruby views/env.rb ") } 
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
    puts self.when_to.inspect, self.when_to.week_day_start
    # must happen before any actions but after all cli argument parsing

    self.begin      if i_should? :begin
    self.change     if i_should? :change
    self.restart    if i_should? :restart
    self.end        if i_should? :end

    self.destroy    if i_should? :destroy

    self.pid        if i_should? :pid
    self.raw        if i_should? :raw
    self.current    if i_should? :current
    puts self.graph      if i_should? :graph
    self.invoice    if i_should? :invoice
    self.console    if i_should? :console
    self.gui        if i_should? :gui
    self.show_env   if i_should? :env
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

  def max 
    self.class.max
  end

  private
    def main
      self.app.reload
      return if self.app.gui?('main', true)
      self.app.log('main')
      projects = ([Project.primary, Project.off] | Project.rest).collect(&:name)
      if Whence.count == 0 
        # first run
        project = Whence.new(:project => Project.primary)
      else
        project = Whence.last_unended || Whence.last
      end
      defork { system("ruby views/main.rb  --projects '#{projects*"','"}' --current '#{project.project.name}'") } 
    end
    def pop
      self.app.reload
      return if self.app.gui?('pop', true)
      self.app.log('pop')
      self.project = Whence.last_unended.project
      defork { system("ruby views/pop.rb  --project '#{project.name}' --start '#{project.whences.last_unended.start_at}' --project_time '#{Pratt.totals(project.time_spent)}'") }
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
      erubis.evaluate(self)
    end

    def padded_to_max string
      self.class.padded_to_max string
    end

    def defork &block
      Process.detach(
        fork &block 
      )
    end

  class << self


    def max
      # TODO Fix me
      @max ||= Project.all.inject(0) {|x,p| x = p.name.length if p.name.length > x; x }
    end

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
        opt.on('-b', "--begin PROJECT_NAME", String, "Begin project tracking.") do |proj|
          me.project = proj
          me << :begin
        end
        opt.on('-r', "--restart [PROJECT_NAME]", String, "Restart project log (stop last log and start a new one).
                                       Applies to last un-ended project, unless a specific project is provided.") do |proj|
          me.project = proj
          me << :restart
        end
        opt.on('-e', "--end [PROJECT_NAME]", String, "Stop tracking interval for last project or supplied project if provided.") do |proj|
          me.project = proj
          me << :end
        end
        opt.on('-c', "--change PROJECT_NAME", String, "Change last time interval to this project.") do |proj|
          me.project = proj
          me << :change
        end
        opt.on('-g', "--graph", String, "Display time spent on supplied project or all projects without argument value.") do |proj|
          me << :graph
        end
        opt.on('-I', "--invoice", "Create an invoice.") do
          me << :invoice
        end
        opt.on('-P', '--pid', "Process id display. (Is it still running)") do
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
        opt.on('--destroy PROJECT_NAME', String, "Remove a project.") do |proj|
          me.project = proj
          me << :destroy
        end

        # Strictly configuration options
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

      me << :env if args.include? 'env'
      me << :console if args.include? 'console'

      me.run
    end

    # Calculate totals. I think this should be an instance method on Projects/?/Whences
    def totals hr, fmt = false
      "#{fmt_i(hr / 24, 'day', :cyan)} #{fmt_i(hr % 24, 'hour', :yellow)} #{fmt_i((60*(hr -= hr.to_i)), 'min', :green)}"
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
      "%#{max}.#{max}s"% string
    end

    # Migrate schema.
    def migrate
      Pratt.root( 'models', '*.rb' ) do |model_file|
        klass = File.basename( model_file, '.rb' ).capitalize.constantize
        begin
          ActiveRecord::Base.connection.table_structure(model_file)
        rescue ActiveRecord::StatementInvalid
          klass.migrate :up if klass.superclass == ActiveRecord::Base
        end
      end
    end
     
      def fmt_i int, label, color
        "%s #{label}"% [("%02i"% int).send(color), label]
      end

  end
end
