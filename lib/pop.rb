#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'

project_name, start_time, project_time = ARGV

yes = proc {
  c = fork { system("ruby bin/pratt.rb --restart '#{project_name}'") }
  Process.detach(c)
  exit 
}
no = proc {
  c = fork { system("ruby bin/pratt.rb --end '#{project_name}' --prompt 'main'") }
  Process.detach(c)
  exit 
}

root = TkRoot.new do
  title "Rebuild Tracker" end

frm = Tk::Tile::Frame.new(root)
top_frm = Tk::Tile::Frame.new(frm)
botm_frm = Tk::Tile::Frame.new(frm)

Tk::Tile::Label.new(top_frm) do
  text "Have you been working on: "
end.pack(:side => 'top', :fill => 'y')

Tk::Tile::Label.new(top_frm) do
  text project_name
end.pack(:side => 'top', :fill => 'y')

Tk::Tile::Label.new(top_frm) do
  text "started:
  #{start_time}
total time:
  #{project_time}."
end.pack(:side => 'bottom', :fill => 'y')

TkButton.new(botm_frm) do
  text "Yes"
  command yes
  underline 0
end.pack('side' => 'left', :fill => 'y')
root.bind("Alt-y", yes)
#root.bind("Return", yes)

TkButton.new(botm_frm) do
  text "No"
  command no
  underline 0
end.pack('side' => 'right', :fill => 'y')
root.bind("Alt-n", no)
root.bind("Escape") { exit }

top_frm.pack( :side => 'top',    :fill => 'y')
botm_frm.pack(:side => 'bottom', :fill => 'y')
frm.pack(     :side => 'top',    :fill => 'y')
root.geometry = "210x120"

Tk.mainloop
