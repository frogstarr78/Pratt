#!/usr/bin/ruby
require "lib/pratt"
require 'optparse'
require 'ostruct'

opts = OpenStruct.new
opts.show         = false
opts.interval     = 15
opts.quit         = false
opts.do_daemonize = false
opts.prompt       = nil
opts.graph        = false

ARGV.options do |opt|
  opt.on('-i', "--interval INTERVAL", Float, "List of projects to display.") do |intvl|
    opts.interval = intvl
  end
  opt.on('-r PROJECT_NAME', "--restart PROJECT_NAME", String, "Restart project (stop last log and start a new one).") do |proj|
    Pratt.new.do :restart!, proj
  end
  opt.on('-b PROJECT_NAME', "--begin PROJECT_NAME", String, "Begin project tracking.") do |proj|
    Pratt.new.do :start!, proj
  end
  opt.on('-e PROJECT_NAME', "--end PROJECT_NAME", String, "End project tracking.") do |proj|
    Pratt.new.do :stop!, proj
  end
  opt.on('-c PROJECT_NAME', "--change PROJECT_NAME", String, "End project tracking.") do |proj|
    Pratt.new.change proj
  end
  opt.on('-g', "--graph [PROJECT_NAME]", String, "End project tracking.") do |proj|
    if proj
      puts "#{(proj = Project.find_by_name(proj)).name}: #{proj.time_spent}"
    else
      projects = Project.all
      max      = projects.inject(0) do |x,p| 
        x = p.name.length if p.name.length > x
        x
      end
      puts projects.collect {|proj| "%1$*3$s: %2$s"% [proj.name, proj.time_spent, max] }
    end
  end

  opt.on('-s', "--show", String, "Show available projects and current project (if there is one)") do |proj|
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    puts "projects: '#{projects*"','"}'"
    if (current = Whence.last).end_at.nil?
      puts " current: '#{current.project.name}'" 
      puts " started: '#{current.start_at}'"
    else
      puts " current: No current project" 
    end
  end
  opt.on("-d", "--daemonize", "Start daemon.") do
    opts.do_daemonize = true
  end
  opt.on("--and_quit", "Stop daemon.") do
    opts.quit = false
  end
  opt.on('-q', "--quit", "Stop daemon.") do
    opts.quit = false
  end
  opt.on('-p WHICH_GUI', '--prompt WHICH_GUI', [:main, :pop], "Flag for prompting a gui (currently: main or pop).") do |gui|
    opts.prompt = gui
  end
  
  opt.parse!
end

opts.interval = opts.interval.to_f

Pratt.run(opts.interval) if opts.do_daemonize
Pratt.new.send opts.prompt if opts.prompt
