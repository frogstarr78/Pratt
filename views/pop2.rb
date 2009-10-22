#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'

$project = self.project

cleanup = proc {
  self.unlock
  exit
}
yes = proc {
  self.when_to = Time.now
  self.restart
  cleanup.call
}
adjust = proc {
  self.when_to = Time.now
  self.end
  self.unlock
  self.gui
  # TODO: Clean up the slop
  cleanup.call
}

root = TkRoot.new { title "Pratt Reminder" }

frm = Tk::Tile::Frame.new(root) { padding "5 5 5 5" }
top_frm = Tk::Tile::Frame.new(frm) { padding "5 5 5 5" }

Tk::Tile::Label.new(top_frm) do
  text "Have you been working on: "
end.pack(:side => 'top', :fill => 'y')

Tk::Tile::Label.new(top_frm) do
  text $project.name
end.pack(:side => 'top', :fill => 'y')

Tk::Tile::Label.new(top_frm) do
  text "started:
  #{$project.whences.last_unended.start_at}
total time:
  #{Pratt.totals($project.time_spent)}."
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
  command cleanup
  underline 0
end.pack('side' => 'right', :fill => 'y')
root.bind("Alt-i", cleanup)
root.bind("Escape", cleanup)

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
