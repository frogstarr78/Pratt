require 'config'
require 'colored'
require 'optparse'
require 'chronic'
require 'fileutils'

class Pratt

  include Config
  include FileUtils
  VERSION = '1.0.0'
  PID_FILE='pratt.pid'
  FMT = "%a %X %b %d %Y"

  attr_accessor :interval, :quit, :daemonize, :prompt, :week, :day, :when_to, :scale, :color, :app
  attr_reader :graph, :project
  def initialize proj = nil #interval, quit, daemonize, prompt, graph, week, day, when_to
    @when_to  = Time.now
    @week     = false
    @day      = false
    @todo     = []
    @scale    = nil
    @interval = 15*60
    @color    = true
    self.project = proj
    @app      = App.last
#    @interval, @quit, @daemonize, @prompt, @graph, @week, @day, @when_to = 
  end

  def project= proj
    if proj.is_a?(Project)
      @project = project
    else
      @project = Project.find_or_create_by_name( { :name => proj } )
    end
  end

  def << what
    @todo << what
  end

  def graph
    projects = 
    if project?
      [project]
    else
      Project.all
    end

    refactor_total = off_total = rest_total = 0.0
    
    puts "Project detail"
    puts [
      "by #{scale.to_s.send(color ? :red : :to_s)} from ", 
      "#{when_to.send("beginning_of_#{scale}").strftime(FMT).send(color ? :blue : :to_s)} to #{when_to.send("end_of_#{scale}").strftime(FMT).send(color ? :blue : :to_s)}"
    ] if scale
    puts ' '*(max+1) << 'dys'.send(color ? :underline : :to_s) << ' '*5 << 'hrs'.send(color ? :underline : :to_s) << ' '*5 << 'min'.send(color ? :underline : :to_s)
    puts '-'*50 unless color
    projects.each do |proj| 
      refactor_total = proj.time_spent(scale, when_to) if proj.name == Project.refactor.name
      off_total      = proj.time_spent(scale, when_to) if proj.name == Project.off.name
      rest_total    += proj.time_spent(scale, when_to) if Project.rest.collect(&:name).include?(proj.name)
      puts "%1$*4$s%2$s %3$s"% [proj.name, (color ? '⋮' : '|'), Pratt.totals(proj.time_spent(scale, when_to), color && true), max]
    end
    puts (color ? '·' : '-')*50
    scaled_total = Whence.time_spent(scale, when_to)-off_total
    puts [
      "%#{max}.#{max}s %s hrs"% ['Total', ("%0.2f"%scaled_total).send(color ? :underline : :to_s)],
      Pratt.percent(Project.refactor.name, refactor_total.to_f, scaled_total, :green,  color && true),
      Pratt.percent(Project.off.name,      off_total.to_f,      scaled_total, :yellow, color && true),
      Pratt.percent('Other',               rest_total.to_f,     scaled_total, :red,    color && true),
    ]
    puts
  end

  def current
    project_names = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    current = Whence.last_unended || Whence.last

    puts "   projects: " << project_names.collect {|project_name| "'#{project_name.send(current.end_at.nil? && current.project.name == project_name ? :green : :magenta)}'" }*' '
    if current.end_at.nil?
      puts "    started: #{current.start_at.strftime(FMT)}"
      time_til = ( interval - ( Time.now - current.start_at ) )
      puts "next prompt: %s %s"% [Pratt.send( :fmt_i, time_til / 60.0, 'min', :yellow, color), Pratt.send( :fmt_i, time_til % 60, 'sec', :yellow, color), ], ''
    end
  end

  def begin
    project.start! when_to
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

  def pid
    p  = `pgrep -f -o 'pratt'`.chomp
    puts "
   pid #{p.cyan} found running
expect #{app.pid.to_s.magenta} ···················· ⌈#{daemonized? ? 'OK'.green : 'Oops'.red}⌋

" 
  end

  def gui
    if Whence.last_unended
      pop
    else
      main
    end
  end

  def main
    return if app.gui?('main', true)
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    if Whence.count == 0 
      # first run
      project = Whence.new(:project => Project.refactor)
    else
      project = Whence.last_unended || Whence.last
    end
    Process.detach(
      fork { system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{project.project.name}'") } 
    )
    app.log('main')
  end

  def pop
    return if app.gui?('pop', true)
    project = Whence.last_unended.project
    Process.detach(
      fork { system("ruby lib/pop.rb '#{project.name}' '#{project.whences.last_unended.start_at}' '#{Pratt.totals(project.time_spent)}'") } 
    )
    app.log('pop')
  end

  def raw
    count     = Project.count
    colors    = %w(red red_on_yellow red_on_white green green_on_blue yellow yellow_on_blue blue magenta magenta_on_blue cyan white white_on_green white_on_blue white_on_magenta black_on_yellow black_on_blue black_on_green black_on_magenta black_on_cyan black_on_red).sort
    Whence.all(:order => "id ASC").each do |whence| 
      color = color ? :to_s : colors[whence.project.id%colors.size]
      str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
      str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
      puts str
    end
  end

  def quit
    project.stop!
    Process.kill("KILL", app.pid.to_i)
    app.pid = ''
    app.gui = ''
    app.save!
  end

  def max 
    self.class.max
  end

  def run
    self.begin      if i_should?(:begin)
    self.change     if i_should?(:change)
    self.restart    if i_should?(:restart)
    self.end        if i_should?(:end)

    self.destroy    if i_should?(:destroy)

    self.pid        if i_should?(:pid)
    self.raw        if i_should?(:raw)
    self.current    if i_should?(:current)
    self.graph      if i_should?(:graph)

    self.quit       if i_should?(:quit)
    
    Process.detach( fork { self.daemonize! } ) if i_should?(:daemonize) and !self.daemonized?
  end

  def daemonized?
    !app.pid.blank? or ( `pgrep -f -o 'pratt -d'`.chomp.to_i == app.pid )
  end

  def daemonize!
    puts "pratt (#{Process.pid.to_s.yellow})"
    app.pid = Process.pid
    app.save!

    main
    while(daemonized?)
      sleep(interval)
      pop
    end
    quit
  end

  private
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
      me = Pratt.new

      args.options do |opt|
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
        opt.on('-R', '--raw', "Dump logs (semi-)raw") do
          me << :raw
        end
        opt.on('-L', '--log', "Redirect errors") do
          $stderr.reopen('log/pratt.log', 'a')
          $stderr.sync = true
        end

        opt.on('-n', '--no-color', "Redirect errors") do 
          me.color = false
        end

        opt.on('--destroy PROJECT_NAME', String, "Remove a project.") do |proj|
          me.project = proj
          me << :destroy
        end

        opt.on('-C', "--current", "Show available projects and current project (if there is one)") do
          me << :current
        end

        opt.on('-i', "--interval INTERVAL", Float, "Set the remind interval/min (Only applies to daemonized process).") do |interval|
          me.interval = interval
        end
        opt.on("-d", "--daemonize", "Start daemon.") do
          me << :daemonize
        end
        opt.on('-q', "--quit", "Stop daemon.") do
          me << :quit
        end
        opt.on('-G', '--gui', 'Show "smart" gui.') do
          me << :gui
        end
        opt.on('-p', '--prompt GUI', [:main, :pop], "Force displaying a gui (currently: main or pop. No default.).") do |gui|
          me.send gui
        end
        opt.on('-U', '--unlock GUI', %w(main, pop), "Manually unlock a gui that has died but left it's lock around.") do |gui|
          me.app.rm(gui)
        end
        
        opt.parse!
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
end
