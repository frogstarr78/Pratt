#
# tile/doc/Makefile --
#
# Generate TMML from nroff source
# Generate HTML from TMML
# 

TMML_DIR	?= /usr/local/lib/tmml
MAN2TMML	= tclsh $(TMML_DIR)/man2tmml/man2tmml.tcl
TMML		= tclsh $(TMML_DIR)/tools/tmml.tcl

HTML_DIR	= html

.SUFFIXES: .3 .n .tmml .html

TMML_OPTIONS = --masterDocument=TILE.XML --htmlDirectory=$(HTML_DIR) --quiet=1

TXTFILES	= converting.txt

default : tmml html

tmml ::
	-mkdir -p xml 
	$(MAN2TMML) -rebuild -directory xml -extension .tmml

html ::
	-mkdir -p $(HTML_DIR)
	$(TMML) makemap $(TMML_OPTIONS) ; mv INDEX.MAP xml
	$(TMML) tohtml xml/*.tmml $(TMML_OPTIONS)
	$(TMML) navpages $(TMML_OPTIONS)
	for file in $(TXTFILES) ; do cp $$file $(HTML_DIR) ; done


clean ::
	-rm $(HTML_DIR)/*.*
	-rm xml/*.*
