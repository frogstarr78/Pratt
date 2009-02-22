# tvtest.tcl,v 1.11 2006/12/18 19:03:33 jenglish Exp
# 
# Sandbox test script for treeview testing 
#

package require tile

source [file join [file dirname [info script]] testutils.tcl]

set haveswaplist [expr {![catch {package require swaplist}]}]
set haveinplace  [expr {![catch {package require tile::inplace}]}]

option add *Toolbar*TCheckbutton.style Toolbutton
option add *Toolbar*TRadiobutton.style Toolbutton
option add *tearOff 0

#
# Tree window:
#
set f [ttk::frame .f]
set tv $f.tv
ttk::scrollbar $f.vsb -orient vertical -command [list $tv yview]
ttk::scrollbar $f.hsb -orient horizontal -command [list $tv xview]
ttk::treeview $tv \
    -columns [list X Y Z] -displaycolumns [list X Y Z] \
    -yscrollcommand [list $f.vsb set] \
    -xscrollcommand [list $f.hsb set] \
    ;

grid $f.tv $f.vsb -sticky news
grid $f.hsb -sticky news
grid columnconfigure $f 0 -weight 1
grid rowconfigure $f 0 -weight 1

#
# Status bar:
#

style configure Indicator.TLabel -relief sunken -borderwidth 1
option add *Indicator.style Indicator.TLabel

set s [ttk::frame .status -class Statusbar]

pack \
    [ttk::label $s.l -class Indicator -textvariable message -width 20] \
    [ttk::label $s.lr -text  "Row:" ] \
    [ttk::label $s.r -class Indicator -textvariable ::irow -width 10] \
    [ttk::label $s.lc -text  "Col:" ] \
    [ttk::label $s.c -class Indicator -textvariable ::icol -width 10] \
    [ttk::label $s.lb -text  "BBox:" ] \
    [ttk::label $s.b -class Indicator -textvariable ::bbox -width 16] \
-side left -pady 2;

#
# View control:
#
set Show(headings) 1
set Show(tree) 1
proc setShow {tv} {
    variable Show
    set show [list]
    foreach {what} [list headings tree] {
    	if {$Show($what)} {
	    lappend show $what 
	}
    }
    $tv configure -show $show
}

set State(selectMode) extended
proc setSelectMode {tv} {
    variable State
    $tv configure -selectmode $State(selectMode)
    $tv selection set {}
}

#
# Menubar:
#
set m [menu .menu]

$m add cascade -label View -underline 0 -menu [menu $m.view] 
$m.view add checkbutton -label "Headings?" \
    -variable Show(headings) -command [list setShow $f.tv]
$m.view add checkbutton -label "Tree?" \
    -variable Show(tree) -command [list setShow $f.tv]
$m.view add separator
$m.view add radiobutton -label "Extended" \
    -variable State(selectMode) -value extended \
    -command [list setSelectMode $f.tv] ;
$m.view add radiobutton -label "Browse" \
    -variable State(selectMode) -value browse \
    -command [list setSelectMode $f.tv] ;
$m.view add radiobutton -label "None" \
    -variable State(selectMode) -value none \
    -command [list setSelectMode $f.tv] ;

. configure -menu $m

#
# Toolbar:
#
ttk::frame .t -class Toolbar
raise .t
pack \
    [ttk::checkbutton .t.sh -text "Headings?" \
    	-variable Show(headings) -command [list setShow $f.tv]] \
    [ttk::checkbutton .t.st -text "Tree?" \
    	-variable Show(tree) -command [list setShow $f.tv]] \
    [ttk::button .t.db -text "Directory" -command [list dirbrowse [pwd]]] \
    -side left;

if {$haveswaplist} {
    pack \
	[ttk::button .t.cl -text "Columns" -command [list selectColumns $tv]] \
    -side left;
}

foreach selectmode {extended browse none} {
    pack [ttk::radiobutton .t.sm-$selectmode -text $selectmode \
	    -variable State(selectMode) -value $selectmode \
	    -command [list setSelectMode $tv] \
    ] -side left;
}

#
# Configure tree:
#
$tv heading #0 -text "Tree"
$tv heading X -text "XXX"
$tv heading Y -text "YYY"
$tv heading Z -text "ZZZ"

pack .t -side top -expand false -fill x
pack .status -side bottom -expand false -fill x
pack .f -side top -expand true -fill both -padx 6 -pady 6

bind . <KeyPress-Escape> [list destroy .]

bind $tv <Motion> { identify %W %x %y }
bind $tv <KeyPress-Delete> { %W delete [%W selection] }

# identify --
#	Update status bar
#
proc identify {tv x y} {
    # Old form:
    set ::message [$tv identify $x $y]

    # New form:
    set ::irow [$tv identify row $x $y]
    set ::icol [$tv identify column $x $y]

    if {$::irow ne ""} {
	if {$::icol ne ""} { 
	    set ::bbox [$tv bbox $::irow $::icol] 
	} else {
	    set ::bbox [$tv bbox $::irow]
	}
    } else {
	set ::bbox N/A
    }
}

## Add some nodes:
#

$tv insert {} end -id a -text "First node" -values [list a1 a2 a3]
$tv insert {} end -id b -text "Second node" -values [list b1 b2 b3]
$tv insert {} end -id c -text "Third node" -values [list c1 c2 c3]

$tv insert {} end -id moveme -text "Press ^M to move me" -values {- - -}
bind $tv <Control-KeyPress-m> {
    %W move moveme [%W parent [%W focus]] [%W index [%W focus]]
    ttk::treeview::BrowseTo %W moveme
}
bind $tv <Control-Shift-KeyPress-M> {
    %W move moveme [%W focus] 0
    ttk::treeview::BrowseTo %W moveme
}

$tv insert a end -id a1 -text "First subnode" -values [list d1 d2 d3]
$tv insert a end -id a2 -text "Second subnode" -values [list e1 e2 e3]
$tv insert a1 end -text "Subsubnode!!" -values [list X! Y! Z!]

foreach label {a b c d e f g h i j k l m n o} {
    $tv insert b end -text $label
}


# Directory browser:

# SOURCE: tkfbox.tcl
set Icons(folder) [image create photo -data {
R0lGODlhEAAMAKEAAAD//wAAAPD/gAAAACH5BAEAAAAALAAAAAAQAAwAAAIghINhyycvVFsB
QtmS3rjaH1Hg141WaT5ouprt2HHcUgAAOw==}]

set Icons(file) [image create photo -data {
R0lGODlhDAAMAKEAALLA3AAAAP//8wAAACH5BAEAAAAALAAAAAAMAAwAAAIgRI4Ha+IfWHsO
rSASvJTGhnhcV3EJlo3kh53ltF5nAhQAOw==}]

proc loaddir {tv node dir} {
    variable Icons
    foreach subdir [glob -nocomplain -type d -directory $dir *] {
        set dirnode [$tv insert $node end -text [file tail $subdir] \
    		-image $Icons(folder) -tags DIR -values [list X Y Z]]
	loaddir $tv $dirnode $subdir
    }
    foreach file [glob -nocomplain -type f -directory $dir *] {
	$tv insert $node end -text [file tail $file] \
	    -image $Icons(file) -tags FILE -values [list X Y Z]
    }
}

proc scandir {dir} {
    foreach subdir [glob -nocomplain -type d -directory $dir *] {
    	scandir $subdir
    }
    glob -nocomplain -type f -directory $dir *
}

proc dirbrowse {dir} {
    set tv $::tv
    $tv tag bind DIR <Double-ButtonPress-1> { 
	puts "DIR: [%W item [%W identify row %x %y] -text]"
    }
    $tv tag bind FILE <Double-ButtonPress-1> { 
	puts "FILE: [%W item [%W identify row %x %y] -text]"
    }
    $tv tag configure DIR -foreground #000077 -background #777700
    $tv tag configure FILE -foreground #007700 -background #770077
    loaddir $tv [$tv insert {} end -text $dir -tags DIR] $dir
}


proc setWidths {tv {weights {}} {width {}}} {
    if {$width eq {}} { set width [winfo width $tv] }
    array set W $weights

    set columns [$tv cget -displaycolumns]
    if {![llength $columns]} {
	set columns [$tv cget -columns]
    }
    set columns [linsert $columns 0 "#0"]

    set totalWeight 0.0
    set weights [list]
    foreach column $columns {
	if {[info exists W($column)]} {
	    set weight $W($column)
	} else {
	    set weight 1
	}
	lappend weights $weight
	set totalWeight [expr {$totalWeight+$weight}]
    }

    foreach column $columns weight $weights {
	set colwidth [expr {int(($width * $weight)/$totalWeight)}]
	$tv column $column -width $colwidth 
    }
}

proc selectColumns {tv} {
    set columns [$tv cget -displaycolumns]
    if {[swaplist::swaplist $tv.c columns [$tv cget -columns] $columns]} {
    	$tv configure -displaycolumns $columns
    }
}

# ...
if {$haveinplace} {

    bind $tv <ButtonPress-2> { clickToEdit %W %x %y }

    proc clickToEdit {tv x y} {
	set row [$tv identify row $x $y]
	set column [$tv identify column $x $y]
	if {$row ne "" && $column ne ""} {
	    ttk::treeview::edit $tv $row $column
	}
    }
}

menu $tv.m -tearoff false -borderwidth 1
bind $tv <ButtonPress-3> [list column-menu/post $tv $tv.m %x %y]

proc column-menu/post {tv m x y} {
    upvar #0 $m M

    set M(tv) $tv
    set M(column) [$tv identify column $x $y]
    set M(stretch) [$tv column $M(column) -stretch]

    set displaycolumns [$tv cget -displaycolumns]
    foreach column [$tv cget -columns] {
	set M(show.$column) [expr {[lsearch $displaycolumns $column] >= 0}]
    }

    $m delete 0 end
    $m add checkbutton -label "Stretch?" \
    	-variable ${m}(stretch) \
	-command [list column-menu/stretch-changed $m] \
	;
    $m add separator
    foreach column [$tv cget -columns] {
    	$m add checkbutton \
	    -label [$tv heading $column -text] \
	    -variable ${m}(show.$column) \
	    -command [list column-menu/show-changed $m] \
	    ;
    }

    tk_popup $m [winfo pointerx $m] [winfo pointery $m]
}

proc column-menu/show-changed {m} {
    upvar #0 $m M
    set tv [winfo parent $m]
    set displaycolumns [list]
    foreach column [$tv cget -columns] {
	if {$M(show.$column)} {
	    lappend displaycolumns $column
	}
    }
    $tv configure -displaycolumns $displaycolumns
}

proc column-menu/stretch-changed {m} {
    upvar #0 $m M
    $M(tv) column $M(column) -stretch $M(stretch)
}
