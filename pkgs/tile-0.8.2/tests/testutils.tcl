#
# testutils.tcl,v 1.2 2006/11/24 19:42:28 jenglish Exp
#
# Miscellaneous utilities for interactive tests.
#


# Global binding: <Alt-KeyPress-t> cycles the current theme.
#
variable currentTheme alt
proc CycleTheme {} {
    variable currentTheme
    set themes [tile::availableThemes]
    set i [expr {([lsearch $themes $currentTheme] + 1) % [llength $themes]}]
    tile::setTheme [set currentTheme [lindex $themes $i]]
    puts "Theme: $currentTheme"
}
bind all <Alt-KeyPress-t> { CycleTheme }

lappend auto_path /usr/local/lib
