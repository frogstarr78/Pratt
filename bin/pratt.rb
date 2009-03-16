#!/usr/bin/ruby

require 'fileutils'
FileUtils.chdir File.dirname(File.expand_path('..', File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__ ) )
require "lib/pratt"

Pratt.parse(ARGV)
