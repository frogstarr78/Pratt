#
# side-by-side interactive test of Tk vs. Tile scrollbars.
#

lappend auto_path .

package require Tk
package require tile

proc sbstub {sb cmd number {units units}} {
    # puts [info level 0]
    sbstub.$cmd $sb $number $units
}
proc sbstub.moveto {sb number _} {
    $sb set $number [expr {$number + 0.5}]
    # puts "[$sb get]"
}
proc sbstub.scroll {sb number units} {
    if {$units eq "pages"} {
    	set delta 0.2
    } else {
	set delta 0.05
    }
    set current [$sb get]
    set new0 [expr {[lindex $current 0] + $delta*$number}] 
    set new1 [expr {[lindex $current 1] + $delta*$number}]
    $sb set $new0 $new1 ;
    # puts "$current - $new0 $new1 - [$sb get]"
}

wm geometry . 400x200

pack [scrollbar .hsb -orient horizontal -command [list sbstub .hsb]] \
    -side top -expand false -fill x
pack [tscrollbar .thsb -orient horizontal -command [list sbstub .thsb]]  \
    -side top -expand false -fill x
pack [scrollbar .vsb -orient vertical -command [list sbstub .vsb]] \
    -side left -expand false -fill y
pack [tscrollbar .tvsb -orient vertical -command [list sbstub .tvsb]] \
    -side left -expand false -fill y

pack [set c [frame .client]] -expand true -fill both

grid \
	[label $c.li -text "Element:" -anchor w] \
	[entry $c.i -textvariable ::identified] \
	-sticky ew

grid \
	[label $c.lf -text "Fraction:" -anchor w] \
	[entry $c.f -textvariable ::fraction] \
	-sticky ew

grid \
	[label $c.lr -text "Range:" -anchor w] \
	[entry $c.r -textvariable ::range] \
	-sticky ew

grid columnconfigure $c 1 -weight 1

bind Test <ButtonPress-1>  { sbdebug %W %x %y }
bind Test <B1-Motion>      { sbdebug %W %x %y }
bind Test <B2-Motion>      { sbdebug %W %x %y }

proc sbdebug {W x y} {
    set ::identified [$W identify $x $y] 
    set ::fraction [$W fraction $x $y]
    set ::range [$W get]
}

foreach w {.vsb .hsb .tvsb .thsb} {
    bindtags $w [linsert [bindtags $w] 0 Test]
}

.vsb set 0 0.5
.hsb set 0 0.5
.tvsb set 0 0.5
.thsb set 0 0.5

