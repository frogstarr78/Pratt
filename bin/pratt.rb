#!/usr/bin/ruby

require 'fileutils'
FileUtils.chdir File.dirname(File.expand_path('..', File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__ ) )
require "lib/pratt"

$stderr.reopen("log/pratt.log", 'w')
$stderr.sync = true

Pratt.parse(ARGV)
