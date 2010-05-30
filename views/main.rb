#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'
require 'ostruct'

opts = OpenStruct.new
opts.projects = []
opts.current  = -1
opts.env      = :development

ARGV.options do |opt|
  opt.on('-e', '--environment ENVIRON', String, "Environment to run under.") do |env|
    opts.env      = env
  end
  opt.on('-p x,y,z', "--projects x,y,z", Array, "List of projects to display.") do |projs|
    opts.projects = projs
  end
  opt.on('-c', '--current CURRENT', String, "Set the current task.") do |cur|
    opts.current  = opts.projects.index(cur)
  end
  opt.parse!
end

opts.current = opts.projects.index(opts.current) if opts.current == -1

root = TkRoot.new { title "Pratt Main" }

button_holder        = Tk::Tile::Frame.new(root){ padding "5 5 5 5" }
button_holder_top    = Tk::Tile::Frame.new(button_holder) { padding "5 5 5 5" }

project_combo  = Tk::Tile::TCombobox.new(button_holder_top)
project_combo.values = opts.projects
project_combo.current = opts.current unless opts.current.nil?
project_combo.pack('side' => 'bottom', 'fill' => 'y')

change = proc {
  Process.detach(   
    fork { system("ruby bin/pratt.rb --project '#{project_combo.get}' --change --begin --unlock") } 
  )
  exit
}
quit = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb --project '#{project_combo.get}' --end --unlock --quit") }
  )
  exit
}
start = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb --project '#{project_combo.get}' --begin --unlock") }
  )
  exit
}

Tk::Tile::Label.new(button_holder_top) { text "What will you be working on?" }.pack('side' => 'top', :fill => 'y')

button_holder_bottom = Tk::Tile::Frame.new(button_holder) { padding "5 5 5 5" }
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
