#!/usr/bin/ruby
require 'tk'
require 'tk/image'
require 'tkextlib/tile'
require 'lib/tktray'
require 'optparse'
require 'ostruct'

root = TkRoot.new { title "Pratt Reminder" }

minimize = proc { 
  root.iconify 
}
toggle = proc {
  if root.state == 'normal'
    root.iconify 
  else
    root.deiconify 
  end
}

img = TkPhotoImage.new(:file => '/var/www/localhost/icons/quill.gif')
tray = Tk::Tile::TkTrayIcon.new(root) do
  image img
end
tray.bind '3', proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb --tray") }
  )
}

TkButton.new root do
  image img
  command minimize
end.pack :side => 'top', :fill => 'y'


root.bind("Control-q", proc { exit })

Tk.mainloop
