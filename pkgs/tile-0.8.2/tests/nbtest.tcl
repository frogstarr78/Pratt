#
# Test case for #1368921 "ttk::notebook::enableTraversal"
#
# Test toplevel and mnemonic activation in the presence of 
# multiple notebooks, nested notebooks, and traversal-enabled 
# notebooks that have been destroyed.
#

package require tile

bind TNotebook <Control-KeyPress-F4>	{ destroy [%W select] }
bind TNotebook <Shift-KeyPress-F4>	{ destroy %W }
# Argh.  Shift-KeyPress-Fn bindings don't work under XFree
bind TNotebook <Control-KeyPress-F3>	{ destroy %W }

set pw [ttk::panedwindow .pw -orient vertical]

foreach nb {.pw.nb1 .pw.nb2} {
    $pw add [ttk::notebook $nb] -weight 1
    ttk::notebook::enableTraversal $nb
    foreach {k} {foo bar qux} {
	set label [string totitle $k] 
	$nb add [ttk::button $nb.$k -text $label \
		    -command [list destroy $nb.$k]] \
	    -text $label -underline 0
    }
    $nb add [ttk::notebook $nb.nested] -text Nested -underline 0
    ttk::notebook::enableTraversal $nb.nested
    foreach {k} {asdf zxcv uiop} {
	set label [string totitle $k] 
	$nb.nested add [ttk::button $nb.nested.$k -text $label \
		    -command [list destroy $nb.nested.$k]] \
	    -text $label -underline 0
    }
}

# Command frame:
#
option add *TButton.default normal
set cmd [ttk::frame .cmd] 
grid x \
    [ttk::button $cmd.ok -text OK -command [list destroy .]] \
    [ttk::button $cmd.cancel -text Cancel -command [list destroy .]] \
    -padx 6 -pady 6 ;
grid columnconfigure $cmd 0 -weight 1
keynav::defaultButton $cmd.ok
bind . <KeyPress-Escape> [list event generate $cmd.cancel <<Invoke>>]

# Status bar
#
set status [ttk::frame .status -class Statusbar]
foreach v {focus key element} {
    pack [ttk::label $status.$v -textvariable ::Status($v) -anchor w \
	    -width 20 -relief sunken -borderwidth 1] \
	-side left -expand false -fill none
}
bind all <FocusIn> {+set ::Status(focus) "Focus: %W" }
bind all <KeyPress> {+set ::Status(key) "Key: %K" }
bind TNotebook <Motion> { 
    set ::Status(element) "[%W identify %x %y] [%W index @%x,%y]"
}

pack $status -side bottom -expand false -fill x
pack $cmd -side bottom -expand false -fill x
pack $pw -side top -expand true -fill both

