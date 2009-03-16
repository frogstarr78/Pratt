#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'

project_name, start_time, project_time = ARGV

yes = proc {
  c = fork { system("ruby bin/pratt.rb --restart '#{project_name}' --unlock 'pop'") }
  Process.detach(c)
  exit 
}
adjust = proc {
  c = fork { system("ruby bin/pratt.rb --end '#{project_name}' --unlock 'pop' --prompt 'main'") }
  Process.detach(c)
  exit 
}
ignore = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb --unlock 'pop'") }
  )
  exit 
}

root = TkRoot.new { title "Pratt Reminder" }

frm = Tk::Tile::Frame.new(root) { padding "5 5 5 5" }
top_frm = Tk::Tile::Frame.new(frm) { padding "5 5 5 5" }

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

botm_frm = Tk::Tile::Frame.new(frm) { padding "5 5 5 5" }
TkButton.new(botm_frm) do
  text "Yes"
  command yes
  underline 0
end.pack('side' => 'left', :fill => 'y')
root.bind("Alt-y", yes)
#root.bind("Return", yes)

TkButton.new(botm_frm) do
  text "Ignore"
  command adjust
  underline 0
end.pack('side' => 'right', :fill => 'y')
root.bind("Alt-i", ignore)
root.bind("Escape", ignore)

TkButton.new(botm_frm) do
  text "Adjust"
  command adjust
  underline 0
end.pack('side' => 'right', :fill => 'y')
root.bind("Alt-a", adjust)

top_frm.pack( :side => 'top',    :fill => 'y')
botm_frm.pack(:side => 'bottom', :fill => 'y')
frm.pack(     :side => 'top',    :fill => 'y')

Tk.mainloop
