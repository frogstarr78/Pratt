#!/usr/bin/env ruby

require 'fileutils'
FileUtils.chdir Dir.pwd

require "lib/pratt"

Pratt.parse(ARGV)
