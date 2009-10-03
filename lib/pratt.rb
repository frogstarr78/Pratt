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

require 'models/app'
require 'models/whence'
require 'models/project'
module NoColor
  include Colored

  COLORS.each do |color, value|
    define_method(color) do 
      self.to_s
    end

    define_method("on_#{color}") do
      self.to_s
    end

    COLORS.each do |highlight, value|
      next if color == highlight
      define_method("#{color}_on_#{highlight}") do
        self.to_s
      end
    end
  end

  EXTRAS.each do |extra, value|
    next if extra == 'clear'
    define_method(extra) do 
      self.to_s
    end
  end
end

class Pratt

  include Config
  include FileUtils
  VERSION = '1.0.0'
  PID_FILE='pratt.pid'
  FMT = "%a %X %b %d %Y"

  attr_accessor :when_to, :scale, :color, :show_all, :env, :raw_conditions
  attr_reader :project
  def initialize proj = nil #, when_to
    @when_to        = Time.now
    @week           = false
    @day            = false
    @todo           = []
    @scale          = nil
    @color          = true
    @show_all       = false
    @env            = :development
    @raw_conditions = ''
    self.project = proj unless proj.nil?
  end

  def project= proj
    if proj.is_a?(Project)
      @project = proj
    else
#      Pratt.connect self.env
      @project = Project.find_or_create_by_name( { :name => proj } )
    end
  end

  def << what
    @todo << what
  end

  def app
    @app ||= App.last
    @app
  end

  def graph
    primary = off_total = rest_total = 0.0

    puts "Project detail"
    puts [
      "by #{scale.to_s.red} from ", 
      "#{when_to.send("beginning_of_#{scale}").strftime(FMT).blue} to #{when_to.send("end_of_#{scale}").strftime(FMT).blue}"
    ] if scale
    puts ' '*(max+1) << 'dys'.send(color ? :underline : :to_s) << ' '*5 << 'hrs'.send(color ? :underline : :to_s) << ' '*5 << 'min'.send(color ? :underline : :to_s)
    puts (color ? '·' : '-')*60

    if project?
      projects = [project]

      primary = project.time_spent(scale, when_to)
      scaled_total = project.whences.time_spent(scale, when_to)
    else
      projects = Project.all

      projects.each do |proj| 
        primary = proj.time_spent(scale, when_to) if proj.name == Project.primary.name
        off_total      = proj.time_spent(scale, when_to) if proj.name == Project.off.name
        rest_total    += proj.time_spent(scale, when_to) if Project.rest.collect(&:name).include?(proj.name)
      end
      scaled_total = Whence.time_spent(scale, when_to)-off_total
    end

    projects.each do |proj| 
      puts "%1$*4$s%2$s %3$s"% [proj.name, (color ? '⋮' : '|'), Pratt.totals(proj.time_spent(scale, when_to), color && true), max] if show_all or ( !show_all and proj.time_spent(scale, when_to) != 0.0 )
    end
    puts (color ? '·' : '-')*60
    puts [
      "%#{max}.#{max}s %s hrs"% ['Total', ("%0.2f"%scaled_total).send(color ? :underline : :to_s)],
      Pratt.percent(Project.primary.name, primary.to_f, scaled_total, :green,  color && true),
      Pratt.percent(Project.off.name,      off_total.to_f,      scaled_total, :yellow, color && true),
      Pratt.percent('Other',               rest_total.to_f,     scaled_total, :red,    color && true),
    ]
    puts
  end

  def graph2
    @primary = @off_total = @rest_total = 0.0

    if project?
      @projects = [project]

      @primary = project.time_spent(@scale, @when_to)
      @scaled_total = project.whences.time_spent(@scale, @when_to)
    else
      @projects = Project.all

      @projects.each do |proj| 
        @primary     = proj.time_spent(@scale, @when_to) if proj.name == Project.primary.name
        @off_total   = proj.time_spent(@scale, @when_to) if proj.name == Project.off.name
        @rest_total += proj.time_spent(@scale, @when_to) if Project.rest.collect(&:name).include?(proj.name)
      end
      @scaled_total = Whence.time_spent(@scale, @when_to)-@off_total
    end

    input = File.read('views/graph.eruby')
    eruby = Erubis::Eruby.new(input)
    puts eruby.evaluate(self)
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
        puts "next prompt: %s %s"% [Pratt.send( :fmt_i, time_til / 60.0, 'min', :yellow, color ), Pratt.send( :fmt_i, time_til % 60, 'sec', :yellow, color ), ], ''
      end
    else
      puts "   projects: " << (
        project_names.collect do |project_name| 
          "'#{project_name.send(:magenta)}'" 
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
    puts "
   pid #{cpid.cyan} found running
expect #{app.pid.to_s.magenta} ···················· ⌈#{daemonized? ? 'OK'.green : 'Oops'.red}⌋

" 
  end

  def raw
    count     = Project.count
    str       = ''
    colors    = %w(red red_on_yellow red_on_white green green_on_blue yellow yellow_on_blue blue magenta magenta_on_blue cyan white white_on_green white_on_blue white_on_magenta black_on_yellow black_on_blue black_on_green black_on_magenta black_on_cyan black_on_red).sort
    if project = Project.find_by_name( raw_conditions )
      project.whences.all(:order => "id ASC").each do |whence| 
        color = self.color ? colors[whence.project.id%colors.size] : :to_s
        str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
        str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
        puts str
      end
    else
      case raw_conditions
        when /last/
          if when_to = Chronic.parse(raw_conditions)
            Whence.all(:conditions => ["start_at > ?", when_to], :order => "id ASC").each do |whence| 
              color = self.color ? colors[whence.project.id%colors.size] : :to_s
              str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
              str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
              puts str
            end
          else
            raw_conditions =~ /^(\d+).+$/
            Whence.all(:offset => Whence.count-$1.to_i, :limit => $1.to_i, :order => "id ASC").each do |whence| 
              color = self.color ? colors[whence.project.id%colors.size] : :to_s
              str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
              str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
              puts str
            end
          end
        when 'all', /^last$/, 'first'
          Whence.find(raw_conditions, :order => "id ASC").each do |whence| 
            color = self.color ? colors[whence.project.id%colors.size] : :to_s
            str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
            str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
            puts str
          end
        else
          Whence.all(:conditions => ["start_at > ?", Chronic.parse("today 00:00")], :order => "id ASC").each do |whence| 
            color = self.color ? colors[whence.project.id%colors.size] : :to_s
            str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
            str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
          end
      end

      puts str
#      elsif raw_conditions =~ /^(?:from)?(.+)(?:\-|\ to\ )(.+)$/
#        Whence.all(:conditions => ["start_at BETWEEN ? AND ?", Chronic.parse($1), Chronic.parse($2)], :order => "id ASC").each do |whence| 
#          color = self.color ? colors[whence.project.id%colors.size] : :to_s
#          str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
#          str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
#          puts str
#        end
#      end
    end
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

  def detect
    if self.daemonized?
      gui
    else
      daemonize!
    end
  end

  def run
#    Pratt.connect self.env

    self.begin      if i_should?(:begin)
    self.change     if i_should?(:change)
    self.restart    if i_should?(:restart)
    self.end        if i_should?(:end)

    self.destroy    if i_should?(:destroy)

    self.pid        if i_should?(:pid)
    self.raw        if i_should?(:raw)
    self.current    if i_should?(:current)
    self.graph      if i_should?(:graph)
    self.gui        if i_should?(:gui)
    self.detect     if i_should?(:detect)
    self.app.unlock if i_should?(:unlock)

    self.quit       if i_should?(:quit)
    self.daemonize! if i_should?(:daemonize) and not self.daemonized?
  end

  def daemonized?
    !app.pid.blank? and ( cpid.to_i == app.pid )
  end
  def daemonize!
    Process.detach( 
      fork { 
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
    )
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
      Process.detach(
        fork { system("ruby views/main.rb  --projects '#{projects*"','"}' --current '#{project.project.name}'") } 
      )
    end
    def pop
      self.app.reload
      return if self.app.gui?('pop', true)
      self.app.log('pop')
      project = Whence.last_unended.project
      Process.detach(
        fork { system("ruby views/pop.rb  --project '#{project.name}' --start '#{project.whences.last_unended.start_at}' --project_time '#{Pratt.totals(project.time_spent)}'") } 
      )
    end

    def i_should? what
      @todo.include?(what)
    end

    def project?
      !@project.nil? and @project.name?
    end

  class << self

    def max
      # TODO Fix me
      Project.all.inject(0) {|x,p| x = p.name.length if p.name.length > x; x }
    end

    def parse args
#      Pratt.connect :development

      me = Pratt.new

      begin
      args.options do |opt|
        opt.on('-E', '--environment ENVIRONMENT', DBFILES, "Environment to load") do |to_env|
          me.env = to_env
#          Pratt.connect to_env
        end

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
        opt.on('-g', "--graph [PROJECT_NAME]", String, "Display time spent on supplied project or all projects without argument value.") do |proj|
          me.project = proj
          me << :graph
        end
        opt.on('--destroy PROJECT_NAME', String, "Remove a project.") do |proj|
          me.project = proj
          me << :destroy
        end

        opt.on '-w', '--when_to TIME', String, 'When to do something. 
                                       (e.g. log time start|stop, or what time interval to graph)
                                       If graphing, silently ignored w/out scale argument.' do |when_to|
          me.when_to = Chronic.parse(when_to)
        end
        opt.on('-l', '--scale SCALE', [:day, :week, :month, :quarter, :year], "Granularity of time argument
                                       (day, week, month, quarter, year).
                                       Only applies to graphing.") do |scale|
          me.scale = scale
        end

        opt.on('-P', '--pid', "Process id display. (Is it still running)") do
            me << :pid
        end
        opt.on('-R', '--raw [CONDITIONS]', "Dump logs (semi-)raw") do |conditions|
          me << :raw
          me.raw_conditions = conditions
        end
        opt.on('-L', '--log', "Redirect errors") do
          $stderr.reopen('log/pratt.log', 'a')
          $stderr.sync = true
        end

        opt.on('-N', '--no-color', "Display output without color or special characters.") do 
          String.send(:include, NoColor)
          me.color = false
        end
        opt.on('-A', '--show-all', "Display all project regardless of other options.") do 
          me.show_all = true
        end

        opt.on('-C', "--current", "Show available projects and current project (if there is one)") do
          me << :current
        end

        opt.on('-i', "--interval INTERVAL", Float, "Set the remind interval/min (Only applies to daemonized process).") do |interval|
          me.app.interval = interval
          me.app.save
        end
        opt.on('-D', '--detect', 'Detect appropriate behavior. (Daemonize or Graphical).') do
          me << :detect
        end
        opt.on('-G', '--gui', 'Show "smart" gui.') do
          me << :gui
        end
        opt.on("-d", "--daemonize", "Start daemon.") do
          me << :daemonize
        end
        opt.on('-q', "--quit", "Stop daemon.") do
          me << :quit
        end
        opt.on('-U', '--unlock', "Manually unlock a gui that has died but left it's lock around.") do
          me.app.unlock
#          me << :unlock
        end

        opt.parse!
      end
      rescue => problem
        puts problem.backtrace*"\n"
      end

      me.run
    end

    def totals hr, fmt = false
      "#{fmt_i(hr / 24, 'day', :cyan, fmt)} #{fmt_i(hr % 24, 'hour', :yellow, fmt)} #{fmt_i((60*(hr -= hr.to_i)), 'min', :green, fmt)}"
    end

    def percent label, off, total, color, fmt = false
      fmt_f((off/total)*100, label, color, fmt)
    end
    private

      def fmt_f flt, label, color, fmt = false
        "%#{max}.#{max}s %s"% [label, ("%0.2f%%"% flt).send(fmt ? color : :to_s), label]
      end

      def fmt_i int, label, color, fmt = false
        "%s #{label}"% [("%02i"% int).send(fmt ? color : :to_s), label]
      end
  end


#  def self.included base
#    model_files {|path| require path }
#  end

  def model_files &block
    Pathname.glob( File.join(Dir.pwd, 'models', '*.rb') ).each {|f| 
      yield f
    }
  end

  def migrate
    DBFILES.each do |db|
      Pratt.connect db
      model_files do |path|
        klass = File.basename( path, '.rb' ).capitalize.constantize
        begin
          ActiveRecord::Base.connection.execute("
            CREATE VIEW INFORMATION_SCHEMA_TABLES AS 
              SELECT 'main' AS TABLE_CATALOG,
                     'sqlite' AS TABLE_SCHEMA,
                     tbl_name AS TABLE_NAME,
                     CASE WHEN type = 'table' THEN 'BASE TABLE' WHEN type = 'view' THEN 'VIEW' END AS TABLE_TYPE,
                     sql AS TABLE_SOURCE
                FROM sqlite_master
               WHERE type IN ('table', 'view')
                 AND tbl_name NOT LIKE 'INFORMATION_SCHEMA_%'
            ORDER BY TABLE_TYPE, TABLE_NAME;
          ")
        rescue ActiveRecord::StatementInvalid
        end
        unless ActiveRecord::Base.connection.select_value("SELECT * FROM INFORMATION_SCHEMA_TABLES WHERE TABLE_NAME = '#{klass.table_name}'")
          klass.migrate :up
        end
      end
    end
  end
end

