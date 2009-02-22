#
# cursors.tcl,v 1.3 2006/11/05 18:40:48 jenglish Exp
#
# Tile package: Symbolic cursor names.
#
# @@@ TODO: Figure out appropriate platform-specific cursors
#	for the various functions.
#

namespace eval ttk {

    variable Cursors

    switch -glob $::tcl_platform(platform) {

	"windows" {
	    array set Cursors {
		hresize 	sb_h_double_arrow
		vresize 	sb_v_double_arrow
		seresize	size_nw_se
	    }
	}

	"unix" - 
	* {
	    array set Cursors {
		hresize 	sb_h_double_arrow
		vresize 	sb_v_double_arrow
		seresize	bottom_right_corner
	    }
	}

    }
}

#*EOF*
