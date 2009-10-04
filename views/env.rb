#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'
require 'ostruct'

root = TkRoot.new { title "Pratt Reminder" }

max = ENV.inject(0) {|x,(h,v)| x = h.to_s.length if h.to_s.length > x; x }

ENV.sort.each do |globl, val| 
  Tk::Tile::Label.new(root) do
    text "%#{max}.#{max}s: %0.20s"% [globl, val]
  end.pack(:side => 'top', :fill => 'y')
end

Tk.mainloop
