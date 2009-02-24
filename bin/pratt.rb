#!/usr/bin/ruby
require "lib/pratt"


Pratt.run((ARGV.last || 15).to_i)
