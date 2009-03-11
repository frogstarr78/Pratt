require 'config'
require 'colored'
require 'optparse'
require 'optparse/time'

class Pratt

  include Config
  VERSION = '1.0.0'
#  PID_FILE='/var/run/pratt.pid'
  PID_FILE='pratt.pid'

  attr_accessor :interval, :quit, :do_daemonize, :prompt, :show, :week, :day, :when_to, :scale
  attr_reader :graph, :project
  def initialize proj = nil #interval, quit, do_daemonize, prompt, show, graph, week, day, when_to
    @when_to  = Time.now
    @week     = false
    @day      = false
    @do       = []
    @scale    = nil
    @interval = 15
    self.project = proj
#    @interval, @quit, @do_daemonize, @prompt, @show, @graph, @week, @day, @when_to = 
  end

  def project= proj
    @project = Project.find_or_create_by_name( { :name => proj } )
  end

  def << what
    @do << what
  end

  def graph
    projects = 
    if project?
      [project]
    else
      Project.all
    end
    max = projects.inject(0) {|x,p| x = p.name.length if p.name.length > x; x }
    puts projects.collect {|proj| "%1$*3$s: %2$s"% [proj.name, proj.time_spent(true, scale, when_to), max] }
  end

  def show
    project_names = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    current = Whence.last_unended || Whence.last

    puts "projects: " << project_names.collect {|project_name| "'#{project_name.send(current.end_at.nil? && current.project.name == project_name ? :green : :magenta)}'" }*', '
    puts " started: '#{current.start_at}'" if current.end_at.nil?
  end

  def begin
    project.start!
  end
  def restart
    project.restart!
  end
  def end
    project.stop!
  end
  def change
    Whence.last.change! project.name
  end

  def run
    self.begin      if i_should?(:begin)
    self.restart    if i_should?(:restart)
    self.end        if i_should?(:end)
    self.change     if i_should?(:change)
    self.graph      if i_should?(:graph)
    self.show       if i_should?(:show)

    self.class.run(self.interval) if i_should?(:do_daemonize)
    self.quit       if i_should?(:quit)
  end

  def quit
    Whence.last_unended.stop!
    Process.kill("KILL", File.open(PID_FILE).readline.to_i) && rm(PID_FILE)
  end

  private
    def i_should? what
      @do.include?(what)
    end

    def project?
      !@project.nil? and @project.name?
    end

  class << self
    def parse args
      me = Pratt.new

      args.options do |opt|
#        opt.on('-P', "--Project PROJECT_NAME", String, "Just set the project and be done with it (aka other PROJECT_NAME argument values become optional).") do |proj|
#          me.project = proj
#          me << :begin
#        end
        opt.on('-b', "--begin PROJECT_NAME", String, "Begin project tracking.") do |proj|
          me.project = proj
          me << :begin
        end
        opt.on('-r', "--restart PROJECT_NAME", String, "Restart project (stop last log and start a new one).") do |proj|
          me.project = proj
          me << :restart
          Project.find_or_create_by_name( { :name => proj }).restart!
        end
        opt.on('-e', "--end PROJECT_NAME", String, "End project tracking.") do |proj|
          me.project = proj
          me << :end
          Project.find_or_create_by_name( { :name => proj }).stop!
        end
        opt.on('-c', "--change PROJECT_NAME", String, "End project tracking.") do |proj|
          me.project = proj
          me << :change
        end
        opt.on('-g', "--graph [PROJECT_NAME]", String, "End project tracking.") do |proj|
          me.project = proj
          me << :graph
        end

        opt.on '-w', '--when_to TIME', Time, 'When to do something.' do |when_to|
          me.when_to = when_to
        end
        opt.on('-l', '--scale SCALE', [:day, :week, :month, :quarter, :year], "Granularity of time argument. (Only for graphing)") do |scale|
          me.scale = scale
        end
        opt.on('-R', '--Raw', "Dump logs raw") do
          puts Whence.all.collect(&:inspect)
        end

        opt.on('-s', "--show", "Show available projects and current project (if there is one)") do
          me << :show
        end

        opt.on('-i', "--interval INTERVAL", Float, "List of projects to display.") do |interval|
          me.interval = interval
        end
        opt.on("-d", "--daemonize", "Start daemon.") do
          me << :do_daemonize
        end
        opt.on('-q', "--quit", "Stop daemon.") do
          me << :quit
        end
        opt.on('-p', '--prompt GUI', [:main, :pop], "Flag for prompting a gui (currently: main or pop).") do |gui|
          send gui
        end
        
        opt.parse!
      end

      me.run
    end

    def main
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
    end

    def pop
      project = Whence.last_unended.project
      Process.detach(
        fork { system("ruby lib/pop.rb '#{project.name}' '#{project.whences.last_unended.start_at}' '#{project.time_spent}'") } 
      )
    end

    def run interval = 15.0
      if Pratt.daemonized?
        puts "Pratt appears to be still running at pid (#{File.open(PID_FILE).readline.yellow})."
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
      File.exists?(PID_FILE) and File.open(PID_FILE).readline.to_i != 0
    end

    private
      def pid
        File.open(PID_FILE).readline.to_i
      end

      def daemonize!
#        return if daemonized?
        puts "pratt (#{Process.pid.to_s.yellow})"
        File.open(PID_FILE, 'w') {|f| f.write(Process.pid) }
      end
  end
end
