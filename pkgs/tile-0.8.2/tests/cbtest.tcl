##
# combobox test program:
#
# side-by-side-by-side comparison of Tile, BWidget, and Brian Oakley's combobox
#

#
# Autocomplete: maybe need custom match procedure? (string match -nocase)
#
# Things to check:
# 	Focus indicator
#	Blinking insert cursor (none on readonly combobox)
#	Listbox scrollbar arrow lines up with popdown arrow
#	Mouse cursor (I-beam vs. normal) over various elements.
#	Normal mouse cursor in readonly combobox
#	Location of popdown menu when close to screen edge
#	Focus returns to combobox on Unpost (Cancel and Select)
#	ButtonRelease outside of popdown - Cancel? Select? Leave posted?
#	Keyboard traversal (incl. Shift+Tab).
#	-state disabled: 
#	+ grayed out
#	+ do not take focus on click
#	+ do not post listbox
#	Click in editable combobox -- should set icursor, don't select
#	Keyboard traversal into combobox -- should select
#	Traversal out of combobox (both <Tab> and <Shift-Tab>) 
#	Change value (using other combobox) -- repost listbox --
#	  make sure proper entry is highlighted.
#

lappend auto_path . ; package require tile
package require BWidget
package require combobox

source [file join [file dirname [info script]] testutils.tcl]

set values \
    [list abc def ghi jkl mno pqrs tuv wxyz yabba dabba scooby doobie doo]

set t [ttk::frame .t]

grid	[ttk::label $t.l1 -text "Tile"] \
	[ttk::label $t.l2 -text "BWidget"] \
	[ttk::label $t.l3 -text "Oakley"] \
	-row 1 -sticky news;

ttk::combobox $t.rcb1 -width 30 -textvariable V -values $values -state readonly
ComboBox $t.rcb2 -width 30 -textvariable V -values $values -editable false
combobox::combobox $t.rcb3 -textvariable V -width 30 -listvar values -editable false

ttk::combobox $t.ecb1 -width 30 -textvariable V -values $values
ComboBox $t.ecb2 -width 30 -textvariable V -values $values -editable true ;#-autocomplete true
combobox::combobox $t.ecb3 -textvariable V -width 30 -listvar values -editable true

grid $t.rcb1 $t.rcb2 $t.rcb3 -sticky news -pady 4 -padx 4 -row 2
grid $t.ecb1 $t.ecb2 $t.ecb3 -sticky news -pady 4 -padx 4 -row 3
grid columnconfigure $t 0 -uniform c -weight 1
grid columnconfigure $t 1 -uniform c -weight 1

# Active element monitor:
#
bind $t.rcb1 <Motion> { set ::element [%W identify %x %y] }
bind $t.ecb1 <Motion> { set ::element [%W identify %x %y] }

# Focus monitor:
#
proc focusMonitor {} { set ::focusWidget [focus] ; after 200 focusMonitor }
focusMonitor

# Grab monitor:
#
proc grabMonitor {} {
    global grabWidget
    set grabWidget [grab current]
    if {$grabWidget ne ""} {
	lappend grabWidget [grab status $grabWidget]
    }
    after 200 grabMonitor
}
grabMonitor


set mon [ttk::frame $t.mon]
ttk::label $mon.el -text "Element:" -anchor e
ttk::label $mon.e -textvariable ::element -anchor w
ttk::label $mon.fl -text "Focus:" -anchor e
ttk::label $mon.f -textvariable ::focusWidget -anchor w
ttk::label $mon.gl -text "Grab:" -anchor e
ttk::label $mon.g -textvariable ::grabWidget -anchor w
grid $mon.el $mon.e -row 0 -sticky news
grid $mon.fl $mon.f -row 1 -sticky news
grid $mon.gl $mon.g -row 2 -sticky news

grid columnconfigure $mon 1 -weight 1

grid $t.mon -row 0 -columnspan 2 -sticky nwe

grid rowconfigure $t 4 -weight 1
grid [ttk::frame $t.cmd] -row 5 -sticky nwes -columnspan 3
pack [ttk::button $t.cmd.close -text "Close" -command [list destroy .]] \
	-side right -padx 4 -pady 4

###

pack $t -expand true -fill both
focus $t.ecb1

if {[tk windowingsystem] eq "aqua"} { set Meta Command } { set Meta Alt }

bind all <$Meta-Key-d> { %W configure -state disabled }	;# "&disable"
bind all <$Meta-Key-e> { %W configure -state normal }	;# "&enable"
bind all <$Meta-Key-w> { %W configure -state readonly }	;# "&write-protect"

bind all <$Meta-Key-q> { destroy . }
bind all <$Meta-Key-b> { error "BGerror - testing" }

bind all <Control-ButtonPress-1> { focus -force %W }

bind all <FocusIn>	{ puts "+F: %W" }
bind all <FocusOut>	{ puts "-f: %W" }
bind all <ButtonPress>	{ puts "+B: %W" }
bind all <ButtonRelease>	{ puts "-b: %W" }
bind all <KeyPress-m>	{ puts "---- mark ----" }

# In case of a stuck grab: <Control-Button-1> to set focus; <Alt-q> to quit
