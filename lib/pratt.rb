require 'config'
require 'colored'
require 'optparse'
require 'chronic'
require 'fileutils'

class Pratt

  include Config
  include FileUtils
  VERSION = '1.0.0'
#  PID_FILE='/var/run/pratt.pid'
  PID_FILE='pratt.pid'
  FMT = "%a %X %b %d %Y"

  attr_accessor :interval, :quit, :daemonize, :prompt, :show, :week, :day, :when_to, :scale, :color
  attr_reader :graph, :project
  def initialize proj = nil #interval, quit, daemonize, prompt, show, graph, week, day, when_to
    @when_to  = Time.now
    @week     = false
    @day      = false
    @todo     = []
    @scale    = nil
    @interval = 15
    @color    = true
    self.project = proj
#    @interval, @quit, @daemonize, @prompt, @show, @graph, @week, @day, @when_to = 
  end

  def project= proj
    @project = Project.find_or_create_by_name( { :name => proj } )
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
      "by #{scale.to_s.send(color ? :red : :white)} from ", 
      "#{when_to.send("beginning_of_#{scale}").strftime(FMT).send(color ? :blue : :white)} to #{when_to.send("end_of_#{scale}").strftime(FMT).send(color ? :blue : :white)}"
    ] if scale
    puts ' '*(max+1) << 'dys'.send(color ? :underline : :white) << ' '*5 << 'hrs'.send(color ? :underline : :white) << ' '*5 << 'min'.send(color ? :underline : :white)
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
      "%#{max}.#{max}s %s hrs"% ['Total', ("%0.2f"%scaled_total).send(color ? :underline : :white)],
      Pratt.percent(Project.refactor.name, refactor_total.to_f, scaled_total, :green,  color && true),
      Pratt.percent(Project.off.name,      off_total.to_f,      scaled_total, :yellow, color && true),
      Pratt.percent('Other',               rest_total.to_f,     scaled_total, :red,    color && true),
    ]
    puts
  end

  def show
    project_names = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    current = Whence.last_unended || Whence.last

    puts "projects: " << project_names.collect {|project_name| "'#{project_name.send(current.end_at.nil? && current.project.name == project_name ? :green : :magenta)}'" }*' '
    puts " started: #{current.start_at.strftime(FMT)}" if current.end_at.nil?
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
    project.destroy!
  end

  def run
    self.begin      if i_should?(:begin)
    self.change     if i_should?(:change)
    self.restart    if i_should?(:restart)
    self.end        if i_should?(:end)

    self.destroy    if i_should?(:destroy)

    self.pid        if i_should?(:pid)
    self.raw        if i_should?(:raw)
    self.show       if i_should?(:show)
    self.graph      if i_should?(:graph)

    self.class.run(self.interval) if i_should?(:daemonize)
    self.quit       if i_should?(:quit)
  end

  def pid
    p  = `pgrep -f "pratt -d" | head -1`.split.to_s
    ep = self.class.pid.to_s
    puts "
   pid #{p.cyan} found running
expect #{ep.magenta} ···················· ⌈#{!p.blank? && !ep.blank? && p == ep ? 'OK'.green : 'Oops'.red}⌋

" 
  end


  def raw
    count     = Project.count
    colors    = %w(red red_on_yellow red_on_white green green_on_blue yellow yellow_on_blue blue magenta magenta_on_blue cyan white white_on_green white_on_blue white_on_magenta black_on_yellow black_on_blue black_on_green black_on_magenta black_on_cyan black_on_red).sort
    Whence.all(:order => "id ASC").each do |whence| 
      color = color ? :white : colors[whence.project.id%colors.size]
      str   = "%#{max}.#{max}s ⌈%s"% [("%s"%whence.project.name), whence.start_at.strftime(FMT).send(color)]
      str  += "­%s⌋ %0.2f min"% [whence.end_at.strftime(FMT).send(color), (whence.end_at-whence.start_at)/60] if whence.end_at
      puts str
    end
  end

  def quit
    project.stop!
    Process.kill("KILL", self.class.pid.to_i) && rm(PID_FILE)
  end

  def max 
    self.class.max
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
        opt.on('-L', '--log FILE', String, "Redirect errors") do |log_file|
          $stderr.reopen(log_file, 'a')
          $stderr.sync = true
        end

        opt.on('-n', '--no-color', "Redirect errors") do 
          me.color = false
        end

        opt.on('--destroy PROJECT_NAME', String, "Remove a project.") do |proj|
          me.project = proj
          me << :destroy
        end

        opt.on('-s', "--show", "Show available projects and current project (if there is one)") do
          me << :show
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
        opt.on('-p', '--prompt GUI', [:main, :pop], "Force displaying a gui (currently: main or pop. No default.).") do |gui|
          send gui
          log_gui gui
        end
        opt.on('-U', '--unlock GUI', [:main, :pop], "Manually unlock a gui that has died but left it's lock around.") do |gui|
          rm_gui(gui)
        end
        
        opt.parse!
      end

      me.run
    end

    def main
      return if gui?('main')
      projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
      if Whence.count == 0 
        # first run
        Whence.new(:project => Project.refactor)
      else
        current  = Whence.last_unended || Whence.last
      end
      Process.detach(
        fork { system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{current.project.name}'") } 
      )
      log_gui('main')
    end

    def pop
      return if gui?('pop')
      project = Whence.last_unended.project
      Process.detach(
        fork { system("ruby lib/pop.rb '#{project.name}' '#{project.whences.last_unended.start_at}' '#{Pratt.totals(project.time_spent)}'") } 
      )
      log_gui('pop')
    end

    def run interval = 15.0
      if Pratt.daemonized?
        puts "Pratt appears to be still running at pid (#{pid.to_s.yellow})."
      else
        Process.detach(
          fork {
            daemonize!
            main
            while(daemonized?)
              sleep(interval*60)
              pop
            end
          }
        )
      end
    end

    def daemonized?
      File.exists?(PID_FILE) and pid.to_i != 0
    end

    def pid
      return unless File.exists?(PID_FILE)
      File.open(PID_FILE).readline.to_i
    end

    def totals hr, fmt = false
      "#{fmt_i(hr / 24, 'day', :cyan, fmt)} #{fmt_i(hr % 24, 'hour', :yellow, fmt)} #{fmt_i((60*(hr -= hr.to_i)), 'min', :green, fmt)}"
    end

    def percent label, off, total, color, fmt = false
      fmt_f((off/total)*100, label, color, fmt)
    end
    private

      GUI_FILE = '.gui'
      def log_gui which
        File.open(GUI_FILE, 'w') {|f| f.write(which) } unless gui?('.*', false)
      end

      def rm_gui which
        rm GUI_FILE if gui?(which, false)
      end

      def gui? which, logerr = true
        res = (File.exists?(GUI_FILE) && File.open(GUI_FILE).readline.strip =~ Regexp.new(which.to_s))
        $stderr.write "#{which} already being displayed" if logerr
        res
      end

      def fmt_f flt, label, color, fmt = false
        "%#{max}.#{max}s %s"% [label, ("%0.2f%%"% flt).send(fmt ? color : :to_s), label]
      end
      def fmt_i int, label, color, fmt = false
        "%s #{label}"% [("%02i"% int).send(fmt ? color : :to_s), label]
      end
      def daemonize!
#        return if daemonized?
        puts "pratt (#{Process.pid.to_s.yellow})"
        File.open(PID_FILE, 'w') {|f| f.write(Process.pid) }
      end
  end
end
