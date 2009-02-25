require 'tk'
require 'tkextlib/tile'
require 'lib/pratt_module'
require 'optparse'
#require 'lib/pratt'
include PrattM

project_name = ARGV.first

root = TkRoot.new do
  title "Rebuild Tracker" end

frm = Tk::Tile::Frame.new(root)
top_frm = Tk::Tile::Frame.new(frm)
botm_frm = Tk::Tile::Frame.new(frm)

lbl = Tk::Tile::Label.new(top_frm) do
  text "Have you been working on: "
end.pack(:side => 'top', :fill => 'y')

project_n = Tk::Tile::Label.new(top_frm) do
  text project_name
end.pack(:side => 'bottom', :fill => 'y')

yes_button = TkButton.new(botm_frm) do
  text "Yes"
  command do
    require 'lib/pratt'
    (p = Whence.last_started.project).restart!
    puts p.inspect
    exit 
  end
  underline 0
end.pack('side' => 'left', :fill => 'y')

no_button = TkButton.new(botm_frm) do
  text "No"
  command do
    require 'lib/pratt'
    (p = Whence.last_started.project).do false
    puts p.inspect
    c = fork { system('ruby', "bin/pratt.rb --change '#{project_name}'") }
    Process.detach(c)
    exit 
  end
  underline 0
end.pack('side' => 'right', :fill => 'y')

top_frm.pack( :side => 'top',    :fill => 'y')
botm_frm.pack(:side => 'bottom', :fill => 'y')
frm.pack(     :side => 'top',    :fill => 'y')
root.geometry = "200x75"
#root.bind("Alt-y") { Whence.last_started.project.restart!; exit }
root.bind("Alt-n") { system('ruby', "lib/complex.rb"); exit }

Tk.mainloop
