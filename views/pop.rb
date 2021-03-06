#!/usr/bin/env ruby
require 'tk'
require 'tkextlib/tile'
require 'optparse'
require 'ostruct'

include Tk::Tile

opts = OpenStruct.new
opts.project_name = ''
opts.start_time   = ''
opts.project_time = ''

ARGV.options do |opt|
  opt.on('-p', '--project PROJECT', String, "Set the current task.") do |proj|
    opts.project_name = proj
  end
  opt.on('-s', '--start START_TIME', String, "Set the current task.") do |time|
    opts.start_time = time
  end
  opt.on('-t', '--project_time PROJECT_TIME', String, "Set the current task.") do |time|
    opts.project_time = time
  end
  opt.parse!
end

yes = proc {
  c = fork { system("ruby bin/pratt --project '#{opts.project_name}' --restart --unlock") }
  Process.detach(c)
  exit 
}
adjust = proc {
  c = fork { system("ruby bin/pratt --project '#{opts.project_name}' --end --unlock --gui") }
  Process.detach(c)
  exit 
}

root = TkRoot.new { title "Pratt Reminder" }

frm = Frame.new(root) { padding "5 5 5 5" }
top_frm = Frame.new(frm) { padding "5 5 5 5" }

Label.new(top_frm) do
  text "Have you been working on: "
end.pack(:side => 'top', :fill => 'y')

Label.new(top_frm) do
  text opts.project_name
end.pack(:side => 'top', :fill => 'y')

Label.new(top_frm) do
  text "started:
  #{opts.start_time}
total time:
  #{opts.project_time.gsub(/\e\[[0-9]+m/, '')}."
end.pack(:side => 'bottom', :fill => 'y')

botm_frm = Frame.new(frm) { padding "5 5 5 5" }
TkButton.new(botm_frm) do
  text "Yes"
  command yes
  underline 0
end.pack('side' => 'left', :fill => 'y')
root.bind("Alt-y", yes)
#root.bind("Return", yes)

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
