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

if opts.projects.empty?
  raise 'No Projects' if ARGV.empty?
  opts.projects = ARGV.split(',')
end

opts.current = opts.projects.index(opts.current) if opts.current == -1

root = TkRoot.new { title "Pratt Main" }

main_button_holder   = Tk::Tile::Frame.new(root){ padding "5 5 5 5" }
button_holder_top    = Tk::Tile::Frame.new(main_button_holder) { padding "5 5 5 5" }
button_holder_middle = Tk::Tile::Frame.new(main_button_holder) { padding "5 5 5 5" }
button_holder_bottom = Tk::Tile::Frame.new(main_button_holder) { padding "5 5 5 5" }

project_combo  = Tk::Tile::TCombobox.new(button_holder_top)
project_combo.values = opts.projects
project_combo.current = opts.current
project_combo.pack('side' => 'bottom', 'fill' => 'y')

change = proc {
  Process.detach(   
    fork { system("ruby bin/pratt.rb  --change '#{project_combo.get}' --begin '#{project_combo.get}' --unlock") } 
  )
  exit
}
quit = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb  --end '#{project_combo.get}' --unlock --quit") }
  )
  exit
}
start = proc {
  Process.detach(
    fork { system("ruby bin/pratt.rb  --begin '#{project_combo.get}' --unlock") }
  )
  exit
}

Tk::Tile::Label.new(button_holder_top) { text "What will you be working on?" }.pack('side' => 'top', :fill => 'y')

$project_type = TkVariable.new
Tk::Tile::Label.new(button_holder_middle) { text "Part of project?:" }.pack('side' => 'top', :fill => 'y')
Tk::Tile::RadioButton.new(button_holder_middle) { text "Refactor"; variable @project_type; value '1'  }.pack('side' => 'left')
Tk::Tile::RadioButton.new(button_holder_middle) { text "None";     variable @project_type; value '0'  }.pack('side' => 'left')
Tk::Tile::RadioButton.new(button_holder_middle) { text "Other";    variable @project_type; value '-1' }.pack('side' => 'left')

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
button_holder_middle.pack(:side => 'bottom', :fill => 'y')
main_button_holder.pack(       :side => 'top',    :fill => 'y')

Tk.mainloop
