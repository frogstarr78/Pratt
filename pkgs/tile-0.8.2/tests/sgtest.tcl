#
# sgtest.tcl,v 1.1 2006/08/05 23:18:30 jenglish Exp
#
# Interactive test driver for sizegrip widget.
#

package require Tk
package require tile

source [file join [file dirname [info script]] testutils.tcl]

variable setgrid 0
proc setsetgrid {w} { $w configure -setgrid $::setgrid }

variable wmgeometry
bind . <Configure> { set ::wmgeometry [wm geometry .] }

set tb [ttk::frame .toolbar]
pack \
    [ttk::checkbutton $tb.cb -text "Setgrid?" \
	-command [list setsetgrid .tt] -variable setgrid] \
    [ttk::button $tb.tl -text "+50+50" \
	-command [list wm geometry . +50+50]] \
    [ttk::button $tb.br -text "-50-50" \
	-command [list wm geometry . -50-50]] \
    [ttk::button $tb.cg -text "Reset geometry" \
    	-command [list wm geometry . {}]] \
    -side left -anchor w -padx 3 -pady 3
pack \
    [ttk::label $tb.geometry -width 20 -textvariable wmgeometry] \
    -side right

ttk::sizegrip .grip
ttk::scrollbar .vsb -orient vertical -command [list .tt yview]
ttk::scrollbar .hsb -orient horizontal -command [list .tt xview]
text .tt -setgrid $setgrid -wrap none \
    -xscrollcommand [list .hsb set] -yscrollcommand [list .vsb set] \
    -highlightthickness 0

.tt insert end [read [set fp [open [info script]]]] ; close $fp

grid .toolbar -row 0 -columnspan 2 -sticky nsew
grid .tt   -row 1 -column 0 -sticky nsew
grid .vsb  -row 1 -column 1 -sticky nse
grid .hsb  -row 2 -column 0 -sticky sew
grid .grip -row 2 -column 1 -sticky senw ;# -sticky se
grid columnconfigure . 0 -weight 1
grid rowconfigure . 1 -weight 1

bind all <KeyPress-Escape> [list destroy .]

#*EOF*
