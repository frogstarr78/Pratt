# [20 Mar 2005] - interactive test for Tile panedwindow widget

package require tile

option add *Text.height 10
option add *Listbox.height 5
option add *Listbox.width 20
option add *Panedwindow.opaqueResize 1
option add *Panedwindow.OpaqueResize 1

bind PWTestListbox <ButtonPress-1> 	{focus %W}
bind PWTestListbox <KeyPress-t> 	{ %W configure -height 10 }
bind PWTestListbox <KeyPress-s> 	{ %W configure -height 5 }
bind PWTestListbox <KeyPress-n> 	{ %W configure -width 20 }
bind PWTestListbox <KeyPress-w> 	{ %W configure -width 40 }

proc pwtest.listbox {w args} {
    eval [linsert $args 0 listbox $w]
    bindtags $w [list $w PWTestListbox [winfo class $w] [winfo toplevel $w] all]
    return $w
}

ttk::panedwindow .pw -orient vertical
#panedwindow .pw -opaqueresize true -orient vertical

#frame .pw
#proc .pw-add {win} { pack $win -side top -expand false -fill x }

.pw add [ttk::frame .pw.f1] -weight 1;#$ -stretch always
.pw add [ttk::frame .pw.f2] -weight 1;#$ -stretch always
.pw add [set w3 [pwtest.listbox .pw.f3]] -weight 1;#$ -stretch always
.pw add [ttk::frame .pw.f4] -weight 1;#$ -stretch always

pack [set w1 [pwtest.listbox .pw.f1.l]] -expand true -fill both
pack [set w2 [pwtest.listbox .pw.f2.l]] -expand true -fill both
#X pack [set w3 [pwtest.listbox .pw.f3.l]] -expand true -fill both
pack [set w4 [pwtest.listbox .pw.f4.l]] -expand true -fill both

pack [label .l -textvariable ::element] -side bottom -expand false -fill x
pack .pw -expand true -fill both -side top

bind .pw <Motion> { set ::element "[%W identify %x %y] - %x,%y" }

bind . <KeyPress-Escape> [list destroy .]
#- bind . <KeyPress-h>	[list .pw configure -orient horizontal]
#- bind . <KeyPress-v>	[list .pw configure -orient vertical]

bind PWTestListbox <KeyPress-f> [list pwtest.forget .pw %W]
bind PWTestListbox <KeyPress-r> [list pwtest.remember .pw]

proc pwtest.forget {pw slave} {
    global $pw
    $pw forget $slave
    lappend $pw $slave
}
proc pwtest.remember {pw} {
    global $pw
    foreach slave [set $pw] {
	$pw add $slave
    }
    set $pw [list]
}

foreach w [list $w1 $w2 $w3] {
    foreach string {abc def ghi jkl mno pqr stu vwx yz} {
    	$w insert end $string
    }
}

proc pwtest.save-config {pw} {
    update idletasks;
    lappend config [winfo width $pw] [winfo height $pw]
    set i -1;
    foreach _ [lrange [$pw panes] 1 end] {
	lappend config [$pw sashpos [incr i]]
    }
    return $config
}

proc pwtest.restore-config {pw config} {
    $pw configure -width [lindex $config 0] -height [lindex $config 1]
    set i -1
    foreach sashpos [lrange $config 2 end] {
	$pw sashpos [incr i] $sashpos
    }
}

bind all <Control-KeyPress-s> { set ::A [pwtest.save-config .pw] }
bind all <Control-KeyPress-r> { pwtest.restore-config .pw $::A }

