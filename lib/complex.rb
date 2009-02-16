require 'lib/pratt'
include PrattM

root = TkRoot.new do
  title "Rebuild Tracker"
end

button_holder        = Tk::Tile::Frame.new(root)
button_holder_top    = Tk::Tile::Frame.new(button_holder)
button_holder_bottom = Tk::Tile::Frame.new(button_holder)


project_combo  = Tk::Tile::TCombobox.new(button_holder_top)
project_combo.values = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
project_combo.current = project_combo.values.index(Whence.last.project.name) if Whence.last
project_combo.pack('side' => 'top', 'fill' => 'y')
project_combo.bind("<ComboboxSelected>") { puts 'touched combo' }

message = Tk::Tile::Label.new(button_holder_top) do
#message = TkMessage.new(button_holder_top) do
  text "What have you been/will you be working on?"
end.pack('side' => 'top', :fill => 'y')

TkButton.new(button_holder_bottom) do 
  text 'Change'
  command Pratt.change
  underline 0
end.pack :side => 'left', :fill => 'y'
root.bind("Alt-c") { Whence.last_started.project.restart!; exit }

TkButton.new(button_holder_bottom) do 
  text 'Quit'
  command { exit }
  underline 0
end.pack :side => 'right', :fill => 'y'
root.bind("Alt-q") { Whence.last_started.project.restart!; exit }
root.bind("Control-q") { Whence.last_started.project.restart!; exit }

button_holder_top.pack(   :side => 'top'   , :fill => 'y')
button_holder_bottom.pack(:side => 'bottom', :fill => 'y')
button_holder.pack(       :side => 'top', :fill => 'y')
root.geometry = "265x100"

Tk.mainloop
