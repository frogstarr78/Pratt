#
# Side-by-side comparison of Tile vs. standard entry widgets.
#

lappend auto_path . ; 
package require tile

source [file join [file dirname [info script]] testutils.tcl]

style theme use alt

. configure -padx 10 -pady 10

grid [ttk::scrollbar .tsb -orient horizontal -command [list .te xview]] \
	-pady 2 -sticky news
grid [ttk::entry .te -textvariable ::A -xscrollcommand [list .tsb set]] \
	-pady 2 -sticky news
grid [entry .e -textvariable ::A -xscrollcommand [list .sb set]] \
	-pady 2 -sticky news
grid [ttk::scrollbar .sb -orient horizontal -command [list .e xview]] \
	-pady 2 -sticky news

grid rowconfigure . 1 -weight 1
grid rowconfigure . 2 -weight 1
grid columnconfigure . 0 -weight 1

.te insert end "abcde fghij klmn opqr stuv wxyz"

#
# Test various options.
#
proc configboth {args} { 
    eval .e configure $args
    eval .te configure $args
}
bind all <Alt-Key-d> { configboth -state disabled }	;# "&disable"
bind all <Alt-Key-e> { configboth -state normal }	;# "&enable"
bind all <Alt-Key-w> { configboth -state readonly }	;# "&write-protect"

bind all <Alt-Key-l> { configboth -justify left }
bind all <Alt-Key-r> { configboth -justify right }
bind all <Alt-Key-c> { configboth -justify center }

bind all <Alt-Key-q> { destroy . }


#
# Validation test.
#
# "If you can't see the fnords, they can't eat you."
#
proc nofnords {w p} {
    if {[set i [string first fnord $p]] >= 0} {
	return 0
    }
    if {[set i [string first FNORD $p]] >= 0} {
	$w delete 0 end; 
	$w insert end [string replace $p $i [expr {$i+4}]]
	$w icursor $i
    }
    return 1
}

configboth -validatecommand {nofnords %W %P} -validate all

# Use gaudy colors to highlight selection:
#

proc gaudyColors {} {
    .te configure \
	-insertcolor red -selectbackground blue -selectforeground green
    .e configure \
	-insertbackground red -selectbackground blue -selectforeground green \
	-background white 
}
bind all <Alt-KeyPress-g> { gaudyColors }

#*EOF*
