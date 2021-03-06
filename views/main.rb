#!/usr/bin/env ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'
require 'ostruct'

include Tk::Tile

opts = OpenStruct.new
opts.projects = []
opts.current  = -1

ARGV.options do |opt|
  opt.on('-p x,y,z', "--projects x,y,z", Array, "List of projects to display.") do |projs|
    opts.projects = projs
  end
  opt.on('-c', '--current CURRENT', String, "Set the current task.") do |cur|
    opts.current  = opts.projects.index(cur)
  end
  opt.parse!
end

if opts.projects.empty?
  raise 'No Projects' if ARGV.empty?
  opts.projects = ARGV.split(',')
end

opts.current = opts.projects.index(opts.current) if opts.current == -1

root = TkRoot.new { title "Pratt Main" }

button_holder        = Frame.new(root){ padding "5 5 5 5" }
button_holder_top    = Frame.new(button_holder) { padding "5 5 5 5" }

project_combo  = TCombobox.new(button_holder_top)
project_combo.values = opts.projects
project_combo.current = opts.current || 0
project_combo.pack('side' => 'bottom', 'fill' => 'y')

change = proc {
  Process.detach(   
    fork { system("ruby bin/pratt --project '#{project_combo.get}' --change --begin --unlock") } 
  )
  exit
}
quit = proc {
  Process.detach(
    fork { system("ruby bin/pratt --project '#{project_combo.get}' --end --unlock --quit") }
  )
  exit
}
start = proc {
  Process.detach(
    fork { system("ruby bin/pratt --project '#{project_combo.get}' --begin --unlock") }
  )
  exit
}

Label.new(button_holder_top) { text "What will you be working on?" }.pack('side' => 'top', :fill => 'y')

button_holder_bottom = Frame.new(button_holder) { padding "5 5 5 5" }
TkButton.new(button_holder_bottom) do 
  text 'Start'
  command start
  underline 0
end.pack :side => 'left', :fill => 'y'
root.bind("Alt-s", start)
#root.bind("Return", start)

TkButton.new(button_holder_bottom) do 
  text 'Change'
  command change
  underline 0
end.pack :side => 'left', :fill => 'y'
root.bind("Alt-c", change)

TkButton.new(button_holder_bottom) do 
  text 'Quit'
  command quit
  underline 0
end.pack :side => 'right', :fill => 'y'
root.bind("Alt-q", quit)
root.bind("Control-q", quit)
root.bind("Destroy", quit)

button_holder_top.pack(   :side => 'top'   , :fill => 'y')
button_holder_bottom.pack(:side => 'bottom', :fill => 'y')
button_holder.pack(       :side => 'top',    :fill => 'y')

Tk.mainloop
