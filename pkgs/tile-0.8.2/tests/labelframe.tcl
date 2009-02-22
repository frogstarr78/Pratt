#
# Interactive test for labelframes.
#

lappend auto_path .
package require tile

puts "Loaded tile: [package ifneeded tile [package provide tile]]"
source [file join [file dirname [info script]] testutils.tcl]

#style map . -background {{} blue}

variable anchorStrings { nw n ne en e es se s sw ws w wn }
variable labelanchor nw

variable label "-labelanchor"

set c [ttk::labelframe .actl -text "-labelanchor"]
$c configure -text "" -labelwidget [ttk::label .lbl -textvariable label]
.lbl configure -relief solid -borderwidth 1

foreach string $anchorStrings {
    pack [ttk::radiobutton $c.$string -text $string \
    	-variable labelanchor -value $string -command setAnchor] \
    -side top -expand false -fill x ;
}
pack [ttk::entry $c.editlabel -textvariable label] \
    -side top -expand false -anchor w
bind $c.editlabel <KeyPress-Return> "$c configure -text \[%W get\]" 

proc setAnchor {} {
    variable labelanchor
    .actl configure -labelanchor $labelanchor
}
pack $c -side top -expand true -fill both -padx 10 -pady 10
setAnchor

bind . <Key-Escape> [list destroy .]
bind . <Alt-KeyPress-l> { .actl configure -labelwidget {} -text $::label }
bind . <Alt-KeyPress-w> { .actl configure -labelwidget .lbl }

