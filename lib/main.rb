#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'
require 'lib/pratt_module'
require 'optparse'
require 'ostruct'
#require 'lib/pratt'
include PrattM

opts = OpenStruct.new
opts.projects = []
opts.current  = -1

ARGV.options do |opt|
  opt.on('-p x,y,z', "--projects x,y,z", Array, "List of projects to display.") do |projs|
    opts.projects = projs
  end

  opt.on('-c', '--current CURRENT', "Set the current task.") do |cur|
    opts.current = opts.projects.index(cur)
  end
  opt.parse!
end

if opts.projects.empty?
  raise 'No Projects' if ARGV.empty?
  opts.projects = ARGV.split(',')
end

opts.current = opts.projects.index(opts.current) if opts.current == -1

root = TkRoot.new do
  title "Rebuild Tracker"
end

button_holder        = Tk::Tile::Frame.new(root)
button_holder_top    = Tk::Tile::Frame.new(button_holder)
button_holder_bottom = Tk::Tile::Frame.new(button_holder)


project_combo  = Tk::Tile::TCombobox.new(button_holder_top)
project_combo.values = opts.projects
project_combo.current = opts.current
project_combo.pack('side' => 'top', 'fill' => 'y')
project_combo.bind("<ComboboxSelected>") { puts 'touched combo' }

message = Tk::Tile::Label.new(button_holder_top) do
  text "What have you been/will you be working on?"
end.pack('side' => 'top', :fill => 'y')

TkButton.new(button_holder_bottom) do 
  text 'Start/Continue'
  command do
    c = fork { system("ruby bin/pratt.rb --begin '#{project_combo.get}'") }
    Process.detach(c)
    exit
  end
#  command { Whence.last_started.project.restart!; exit }
  underline 0
end.pack :side => 'left', :fill => 'y'
#root.bind("Alt-s") { Whence.last_started.project.restart!; exit }

TkButton.new(button_holder_bottom) do 
  text 'Change'
  command do
    c = fork { system("ruby bin/pratt.rb --change '#{project_combo.get}'") }
    Process.detach(c)
    exit
  end
#  command { Pratt.change(project_combo.get) }
  underline 0
end.pack :side => 'left', :fill => 'y'
#root.bind("Alt-c") {  Pratt.change(project_combo.get); exit }

TkButton.new(button_holder_bottom) do 
  text 'Quit'
  command do
#    c = fork { system("ruby bin/pratt.rb --end '#{project_combo.get}' --and_quit") }
    c = fork { 
      require 'lib/pratt'
      pratt = Pratt.new
      pratt.do(:end, project_combo.get) and pratt.quit
    }
    Process.detach(c)
    exit
  end
  underline 0
end.pack :side => 'right', :fill => 'y'
#root.bind("Alt-q") { Whence.last_started.project.restart!; exit }
#root.bind("Control-q") { Whence.last_started.project.restart!; exit }

button_holder_top.pack(   :side => 'top'   , :fill => 'y')
button_holder_bottom.pack(:side => 'bottom', :fill => 'y')
button_holder.pack(       :side => 'top', :fill => 'y')
root.geometry = "265x80"

Tk.mainloop
