#!/usr/bin/env ruby

require 'fileutils'
bin_file = __FILE__
bin_file = File.symlink?(bin_file) ? File.readlink(bin_file) : bin_file

bin_path = File.expand_path( '..', bin_file )
pratt_dir = File.dirname( bin_path )
FileUtils.chdir pratt_dir

require "lib/pratt"

Pratt.parse(ARGV)
