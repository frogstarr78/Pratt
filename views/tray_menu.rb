#!/usr/bin/ruby

require 'tk'
require 'tk/image'
require 'tkextlib/tile'
#require '../lib/tktray'
require 'optparse'
require 'ostruct'

root = TkRoot.new do
  title "Pratt Reminder"
  iconphoto TkPhotoImage.new(:file => '/var/www/localhost/icons/quill.gif')
end

stop = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb  --end") }
  )
}
quit = proc { 
  Process.detach(
    fork { system("ruby bin/pratt.rb --unlock --quit") }
  )
  exit
}

TkButton.new(root) do 
  text "Stop #{ARGV.delete_at(0)}"
  command stop
  underline 0
end.pack :side => 'top', :fill => 'y'

TkButton.new(root) do 
  text 'Quit'
  command quit
  underline 0
end.pack :side => 'bottom', :fill => 'y'

root.bind("Control-q", proc { exit })
x, y = ARGV
x ||= 300
y ||= 300
root.geometry "+#{x}+#{y}"

Tk.mainloop
