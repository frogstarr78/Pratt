#!/usr/bin/ruby
require 'tk'
require 'tk/image'
require 'tkextlib/tile'
require 'lib/tktray'
require 'optparse'
require 'ostruct'

#root = TkRoot.new { title "Pratt Reminder" }

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
tray = Tk::Tile::TkTrayIcon.new do
  image img
end
tray.bind '3', proc {
#  TkDialog.new do 
#    text 'Say something'
#  end
  Process.detach(
#    fork { system("ruby bin/pratt.rb --tray") }
    fork { system("ruby views/tray_menu.rb 'Pratt' 1197 2") } 
  )
}

Tk.mainloop
