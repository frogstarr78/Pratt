#!/usr/bin/ruby
require "lib/pratt"
require 'optparse'
require 'ostruct'

opts = OpenStruct.new
opts.interval = 15
opts.action   = :stop
opts.project  = ""
opts.quit     = false

ARGV.options do |opt|
  opt.on('-i', "--interval INTERVAL", Float, "List of projects to display.") do |intvl|
    opts.interval = intvl
  end
  opt.on('-b PROJECT_NAME', "--begin PROJECT_NAME", String, "Begin project tracking.") do |proj|
    opts.project = proj
    opts.action = :start
  end
  opt.on('-e PROJECT_NAME', "--end PROJECT_NAME", String, "End project tracking.") do |proj|
    opts.project = proj
    opts.action = :end
  end
  opt.on('-c PROJECT_NAME', "--change PROJECT_NAME", String, "End project tracking.") do |proj|
    opts.project = proj
    opts.action = :restart
  end

  opt.on("--and_quit", "Stop daemon.") do |projs|
    opts.quit = false
  end

  opt.on('-q', "--quit", "Stop daemon.") do |projs|
    opts.quit = false
  end

  opt.parse!
end

opts.interval = opts.interval.to_f

Pratt.run(opts.interval)
