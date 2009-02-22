#
# source all tests.
#
package require tcltest 2

namespace eval tile {
    set dir [file dirname [info script]]
    set ::tcltest::testsDirectory $dir
    set library [set ::env(TILE_LIBRARY) [file join $dir .. library]]
}
lappend auto_path [pwd] $::tile::library

eval tcltest::configure $::argv
tcltest::runAllTests

if {![catch { package present Tk }]} {
	destroy .
}
