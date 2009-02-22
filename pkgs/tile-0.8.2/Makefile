#
# Makefile.  Generated from Makefile.in by configure.
#

#========================================================================
# The object files are used for linking into the final library.
#========================================================================

GENERIC_OBJECTS	= \
    tkstate.$(OBJEXT) \
    tile.$(OBJEXT) \
    ttkStubInit.$(OBJEXT) \
    separator.$(OBJEXT) \
    frame.$(OBJEXT) \
    button.$(OBJEXT) \
    scrollbar.$(OBJEXT) \
    progress.$(OBJEXT) \
    scale.$(OBJEXT) \
    notebook.$(OBJEXT) \
    paned.$(OBJEXT) \
    entry.$(OBJEXT) \
    treeview.$(OBJEXT) \
    layout.$(OBJEXT) \
    widget.$(OBJEXT) \
    trace.$(OBJEXT) \
    track.$(OBJEXT) \
    blink.$(OBJEXT) \
    scroll.$(OBJEXT) \
    manager.$(OBJEXT) \
    tagset.$(OBJEXT) \
    tkElements.$(OBJEXT) \
    label.$(OBJEXT) \
    altTheme.$(OBJEXT) \
    classicTheme.$(OBJEXT) \
    tkTheme.$(OBJEXT) \
    cache.$(OBJEXT) \
    image.$(OBJEXT) \
    clamTheme.$(OBJEXT)

WIN_OBJECTS	= winTheme.$(OBJEXT) xpTheme.$(OBJEXT) monitor.$(OBJEXT)
MACOSX_OBJECTS	= aquaTheme.$(OBJEXT)

PKG_OBJECTS	= $(GENERIC_OBJECTS) 

PKG_STUB_OBJECTS = ttkStubLib.$(OBJEXT)

#========================================================================
# This is a list of public header files to be installed, if any.
#========================================================================

PKG_HEADERS	= generic/tkTheme.h generic/ttkDecls.h

#========================================================================
# "PKG_LIB_FILE" refers to the library (dynamic or static as per
# configuration options) composed of the named objects.
#========================================================================

PKG_LIB_FILE	= libtile0.8.2.so
PKG_STUB_LIB_FILE = libttkstub.a

BINARIES	= $(PKG_LIB_FILE) $(PKG_STUB_LIB_FILE)

SHELL		= /bin/sh

srcdir		= .
prefix		= /usr
exec_prefix	= /usr

libdir		= ${exec_prefix}/lib
includedir	= ${prefix}/include

DESTDIR		=

PKG_DIR		= $(PACKAGE_NAME)$(PACKAGE_VERSION)
pkglibdir	= $(libdir)/$(PKG_DIR)

top_builddir	= .

INSTALL		= /usr/bin/install -c
INSTALL_PROGRAM	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644
INSTALL_SCRIPT	= ${INSTALL}

PACKAGE_NAME	= tile
PACKAGE_VERSION	= 0.8.2
CC		= gcc
CFLAGS_DEFAULT	= -O2 -fomit-frame-pointer
CFLAGS_WARNING	= -Wall
CLEANFILES	=  pkgIndex.tcl
EXEEXT		= 
LDFLAGS_DEFAULT	=  -Wl,--export-dynamic 
MAKE_LIB	= ${SHLIB_LD} -o $@ $(PKG_OBJECTS) ${SHLIB_LD_LIBS} 
MAKE_SHARED_LIB	= ${SHLIB_LD} -o $@ $(PKG_OBJECTS) ${SHLIB_LD_LIBS}
MAKE_STATIC_LIB	= ${STLIB_LD} $@ $(PKG_OBJECTS)
MAKE_STUB_LIB	= ${STLIB_LD} $@ $(PKG_STUB_OBJECTS)
OBJEXT		= o
RANLIB		= :
RANLIB_STUB	= ranlib
SHLIB_CFLAGS	= -fPIC
SHLIB_LD	= ${CC} -shared ${CFLAGS} ${LDFLAGS_DEFAULT}
SHLIB_LD_LIBS	= ${LIBS} -L/usr/lib -ltclstub8.4 -L/usr/lib -ltkstub8.4
STLIB_LD	= ${AR} cr
TCL_SRC_DIR	= /usr/lib/tcl8.4/include
TCL_BIN_DIR	= /usr/lib
TK_SRC_DIR	= /usr/lib/tk8.4/include
TK_BIN_DIR	= /usr/lib

# Not used by sample, but retained for reference of what Tcl required
TCL_LIBS	= ${DL_LIBS} ${LIBS} ${MATH_LIBS}
TK_LIBS		= -lX11 -ldl  -lpthread -lieee -lm

#========================================================================
# TCLLIBPATH seeds the auto_path in Tcl's init.tcl so we can test our
# package without installing.  The other environment variables allow us
# to test against an uninstalled Tcl.  Add special env vars that you
# require for testing here (like TCLX_LIBRARY).
#========================================================================

EXTRA_PATH	= $(top_builddir):$(TCL_BIN_DIR):$(TK_BIN_DIR)
TCLSH_ENV	= TCL_LIBRARY="`echo $(TCL_SRC_DIR)/library`" \
		  TK_LIBRARY="`echo $(TK_SRC_DIR)/library`" \
		  TILE_LIBRARY="`echo $(srcdir)/library`" \
		  LD_LIBRARY_PATH="$(EXTRA_PATH):$(LD_LIBRARY_PATH)" \
		  PATH="$(EXTRA_PATH):$(PATH)" \
		  TCLLIBPATH="$(top_builddir)"
TCLSH_PROG	= @TCLSH_PROG@
WISH_PROG	= /usr/bin/wish8.4
TCLSH		= $(TCLSH_ENV) $(TCLSH_PROG)
WISH		= $(TCLSH_ENV) $(WISH_PROG)

# The local includes must come first, because the TK_XINCLUDES can be
# just a comment
INCLUDES	=  -I. -I"./generic" \
		  -I"/usr/lib/tcl8.4/include/generic" -I"/usr/lib/tcl8.4/include/unix" -I"/usr/lib/tk8.4/include/generic" -I"/usr/lib/tk8.4/include/unix" 

EXTRA_CFLAGS	= 

DEFS		= -DPACKAGE_NAME=\"tile\" -DPACKAGE_TARNAME=\"tile\" -DPACKAGE_VERSION=\"0.8.2\" -DPACKAGE_STRING=\"tile\ 0.8.2\" -DPACKAGE_BUGREPORT=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_LIMITS_H=1 -DHAVE_SYS_PARAM_H=1 -DUSE_THREAD_ALLOC=1 -D_REENTRANT=1 -D_THREAD_SAFE=1 -DTCL_THREADS=1 -DMODULE_SCOPE=extern\ __attribute__\(\(__visibility__\(\"hidden\"\)\)\) -D_LARGEFILE64_SOURCE=1 -DTCL_WIDE_INT_TYPE=long\ long -DHAVE_STRUCT_STAT64=1 -DHAVE_OPEN64=1 -DHAVE_LSEEK64=1 -DHAVE_TYPE_OFF64_T=1 -DMODULE_SCOPE=extern\ __attribute__\(\(__visibility__\(\"hidden\"\)\)\) -D_LARGEFILE64_SOURCE=1 -DTCL_WIDE_INT_TYPE=long\ long -DHAVE_STRUCT_STAT64=1 -DHAVE_OPEN64=1 -DHAVE_LSEEK64=1 -DHAVE_TYPE_OFF64_T=1 -DUSE_TCL_STUBS=1 -DUSE_TK_STUBS=1 -DBUILD_tile=1  $(EXTRA_CFLAGS)

CONFIG_CLEAN_FILES = Makefile

CPPFLAGS	= 
LIBS		=  -lX11  -lieee -lm
AR		= ar
CFLAGS		=  -pipe ${CFLAGS_DEFAULT} ${CFLAGS_WARNING} ${SHLIB_CFLAGS}  
COMPILE		= $(CC) $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS)

VPATH = $(srcdir)/generic:$(srcdir)/win:$(srcdir)/macosx

all: package libraries

package: $(PKG_LIB_FILE) pkgIndex.tcl

libraries: $(PKG_STUB_LIB_FILE)

#
# Installation rules:
#

install : install-package install-libraries install-headers

install-package :
	@mkdir -p $(DESTDIR)$(pkglibdir)
	$(INSTALL_PROGRAM) $(PKG_LIB_FILE) $(DESTDIR)$(pkglibdir)/$(PKG_LIB_FILE)
	$(INSTALL_DATA) pkgIndex.tcl $(DESTDIR)$(pkglibdir)/pkgIndex.tcl
	for p in $(srcdir)/library/*.tcl ; do \
	    destp=`basename $$p`; \
	    echo " Install $$destp $(DESTDIR)$(pkglibdir)/$$destp"; \
	    $(INSTALL_DATA) $$p $(DESTDIR)$(pkglibdir)/$$destp; \
	done

install-headers: 
	@echo "Installing header files in $(DESTDIR)$(includedir)"
	@mkdir -p $(DESTDIR)$(includedir)
	@list='$(PKG_HEADERS)'; for p in $$list; do \
	    echo "Installing $(srcdir)/$$p" ; \
	    destp=`basename $$p`; \
	    $(INSTALL_DATA) $(srcdir)/$$p $(DESTDIR)$(includedir)/$$destp ; \
	done;

install-libraries:
	@echo "Installing $(PKG_STUB_LIB_FILE) in $(DESTDIR)$(libdir)"
	@mkdir -p $(DESTDIR)$(libdir)
	$(INSTALL_PROGRAM) $(PKG_STUB_LIB_FILE) $(DESTDIR)$(libdir)

# Test section.
# 

TESTLOAD	= -load "load ./$(PKG_LIB_FILE)"
TESTFLAGS	= 

# Piping to cat is necessary on Windows to see the output, and
# harmless on Unix

test: package libraries
	$(WISH) `echo $(srcdir)/tests/all.tcl` $(TESTLOAD) $(TESTFLAGS) | cat

demo: package libraries
	$(WISH) `echo $(srcdir)/demos/demo.tcl`

shell: package libraries
	@$(WISH) $(SCRIPT)

gdb:
	$(TCLSH_ENV) gdb $(WISH_PROG) $(SCRIPT)

$(PKG_LIB_FILE): $(PKG_OBJECTS)
	-rm -f $(PKG_LIB_FILE)
	${MAKE_LIB}
	$(RANLIB) $(PKG_LIB_FILE)

$(PKG_STUB_LIB_FILE): $(PKG_STUB_OBJECTS)
	-rm -f $(PKG_STUB_LIB_FILE)
	${MAKE_STUB_LIB}
	$(RANLIB_STUB) $(PKG_STUB_LIB_FILE)

.SUFFIXES: .c .$(OBJEXT)

.c.o:
	$(COMPILE) -c `echo $<` -o $@

pkgIndex.tcl:
	(\
	echo 'if {[catch {package require Tcl 8.4}]} return';\
	echo 'package ifneeded $(PACKAGE_NAME) $(PACKAGE_VERSION) \
	    [list load [file join $$dir $(PKG_LIB_FILE)] $(PACKAGE_NAME)]'\
	) > pkgIndex.tcl

Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	cd $(top_builddir) \
	  && CONFIG_FILES=$@ CONFIG_HEADERS= $(SHELL) ./config.status

#========================================================================
# Don't modify the file to clean here.  Instead, set the "CLEANFILES"
# variable in configure.in
#========================================================================

clean:  
	-test -z "$(BINARIES)" || rm -f $(BINARIES)
	-rm -f *.$(OBJEXT) core *.core
	-test -z "$(CLEANFILES)" || rm -f $(CLEANFILES)

distclean: clean
	-rm -f *.tab.c
	-rm -f $(CONFIG_CLEAN_FILES)
	-rm -f config.cache config.log config.status

.PHONY: all package clean depend distclean doc install libraries test

# *EOF*
