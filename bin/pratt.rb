#!/usr/bin/ruby
require "lib/pratt"
require 'optparse'
require 'optparse/time'
require 'ostruct'

opts = OpenStruct.new
opts.show         = false
opts.interval     = 15
opts.quit         = false
opts.do_daemonize = false
opts.prompt       = nil
opts.graph        = false
opts.week         = nil
opts.day          = nil

ARGV.options do |opt|
  opt.on('-b', "--begin PROJECT_NAME", String, "Begin project tracking.") do |proj|
    Project.find_or_create_by_name( { :name => proj }).start!
  end
  opt.on('-r', "--restart PROJECT_NAME", String, "Restart project (stop last log and start a new one).") do |proj|
    Project.find_or_create_by_name( { :name => proj }).restart!
  end
  opt.on('-e', "--end PROJECT_NAME", String, "End project tracking.") do |proj|
    Project.find_or_create_by_name( { :name => proj }).stop!
  end
  opt.on('-c', "--change PROJECT_NAME", String, "End project tracking.") do |proj|
    last_log = Whence.last
    last_log.project = Project.find_or_create_by_name proj
    last_log.save
  end

  opt.on('-w', '--week TIME', Time, "What week do you want graphed?") do |week|
    opts.week = week
  end
  opt.on('-a', '--day TIME', Time, "What week do you want graphed?") do |day|
    opts.day = day
  end

  opt.on('-g', "--graph [PROJECT_NAME]", String, "End project tracking.") do |proj|
    if opts.week.nil?
      if proj
        projects = [Project.find_by_name(proj)]
        max      = projects.first.name.size
      else
        projects = Project.all
        max = projects.inject(0) {|x,p| x = p.name.length if p.name.length > x; x }
      end
    else
      if proj
        projects = [Project.find_by_name(proj).whences.all(:conditions => ["start_at BETWEEN ? AND ?", opts.week.beginning_of_week])]
        max      = projects.first.name.size
      else
        projects = Project.all :include => :whences, :conditions => ["start_at BETWEEN ? AND ?", opts.week.beginning_of_week]
        max = projects.inject(0) {|x,p| x = p.name.length if p.name.length > x; x }
      end
    end
    puts projects.collect {|proj| "%1$*3$s: %2$s"% [proj.name, proj.time_spent(true), max] }

  end
  opt.on('-s', "--show", String, "Show available projects and current project (if there is one)") do |proj|
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    current = Whence.last_unended || Whence.last

    puts "projects: " << projects.collect {|project| "'#{project.send(current.end_at.nil? && current.project.name == project ? :green : :magenta)}'" }*', '
    puts " started: '#{current.start_at}'" if current.end_at.nil?
  end

  opt.on('-i', "--interval INTERVAL", Float, "List of projects to display.") do |interval|
    opts.interval = interval
  end
  opt.on("-d", "--daemonize", "Start daemon.") do
    opts.do_daemonize = true
  end
  opt.on('-q', "--quit", "Stop daemon.") do
    Whence.last_unended.stop!
    opts.quit = true
  end
  opt.on('-p', '--prompt GUI', [:main, :pop], "Flag for prompting a gui (currently: main or pop).") do |gui|
    Pratt.send gui
  end
  
  opt.parse!
end

if opts.do_daemonize 
  if Pratt.daemonized?
    puts "Pratt appears to be still running at pid (#{File.open(Pratt::PID_FILE).readline.yellow})."
  else
    Pratt.run(opts.interval)
  end
end

Pratt.quit if opts.quit
