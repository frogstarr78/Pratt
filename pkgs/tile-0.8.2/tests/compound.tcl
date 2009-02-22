#
# Interactive test for -compound option.
#

lappend auto_path .
package require tile

source [file join [file dirname [info script]] testutils.tcl]

# Load icons...
source [file join [file dirname [info script]] ../demos/iconlib.tcl]
set icons {new open error}
foreach icon $icons {
    set Icon($icon) [image create photo -data $ImgData($icon)]
}

ttk::label .tb -image $Icon(new) -text text -compound left -padding 0
label .b -image $Icon(new) -text text -compound left -padx 0 -pady 0

variable compoundStrings {text image center top bottom left right none}

set c [ttk::labelframe .cctl -text "Compound"]
foreach string $compoundStrings {
    pack [ttk::radiobutton $c.$string -text [string totitle $string] \
    	-variable compound -value $string -command setCompound] \
    -side top -expand false -fill x ;
}

set c [ttk::labelframe .ictl -text "Icon"]
set ::Icon(none) ""
pack [ttk::radiobutton $c.inone -text "None" \
    -variable icon -value $string -command setIcon] \
    -side top -expand false -fill x;
foreach string $icons {
    pack [ttk::radiobutton $c.i$string -text $string \
    	-variable icon -value $string -command setIcon] \
    -side top -expand false -fill x;
}

variable anchorStrings {n ne e se s sw w nw center}
set c [ttk::labelframe .actl -text "Anchor"]
foreach string $anchorStrings {
    pack [ttk::radiobutton $c.$string -text $string \
    	-variable anchor -value $string -command setAnchor] \
    -side top -expand false -fill x ;
}

variable reliefStrings {flat groove raised ridge solid sunken}
set c [ttk::labelframe .rctl -text "Relief"]
foreach string $reliefStrings {
    pack [ttk::radiobutton $c.$string -text $string \
    	-variable relief -value $string -command setRelief] \
    -side top -expand false -fill x ;
}

set width 0
spinbox .wctl -textvariable width -command setWidth \
	-from -15 -to 15 -increment 1

pack .cctl -side left -expand false -fill none -anchor n
pack .ictl -side left -expand false -fill none -anchor n
pack .actl -side left -expand false -fill none -anchor n
pack .rctl -side left -expand false -fill none -anchor n
pack .wctl -side left -expand false -fill none -anchor n
pack .tb .b -side top -expand true -fill both

proc setCompound {} {
    .tb configure -compound $::compound
    catch { .b configure -compound $::compound }
}

proc setAnchor {} {
    .tb configure -anchor $::anchor
    .b configure -anchor $::anchor
}

proc setRelief {} {
    .tb configure -relief $::relief
    .b configure -relief $::relief
}

proc setIcon {} {
    global Icon icon
    .tb configure -image $Icon($icon)
    .b configure -image $Icon($icon)
}

proc setWidth {} {
    .tb configure -width $::width
    .b configure -width $::width
}

