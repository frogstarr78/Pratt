# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Pratt}
  s.version = "1.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Noel-Hemming"]
  s.date = %q{2010-05-30}
  s.default_executable = %q{pratt.rb}
  s.description = %q{
	  Need a way to keep track of your time, but get caught up in work? Or constant interruptions?
	  Yeah you know who I'm talking about. Those people from the [abc] department always "NEEDING xyz FEATURE NOW!!!".
	  Seriously though. I'm usually just loose track of time. I wanted an app that I could start with a task I think 
	  I'll be working on, but that get's in my face constantly to ensure I'm still working on it. And if I'm not any longer,
	  provides an easy way of changing to another task, or if I have changed tasks and not already updated the app, would 
	  provide an easy way of changing the task of the previously recorded interval. That's what this is intended to do.

	  Time Tracking.
	  Proactively set what you expect to work on.
	  Reactively modify what you are no longer working on.
  }
  s.email = %q{frogstarr78@gmail.com}
  s.executables = ["pratt.rb"]
  s.extra_rdoc_files = [
    "README.html",
     "README.txt",
     "TODO"
  ]
  s.files = [
    ".exrc",
     ".gitignore",
     "History.txt",
     "Manifest.txt",
     "Pratt.gemspec",
     "Pratt.mm",
     "README.html",
     "README.txt",
     "Rakefile",
     "Session.vim",
     "TODO",
     "VERSION",
     "bin/pratt.rb",
     "config.rb",
     "db/sqlite_databases_go_here",
     "db/zips.csv.zip",
     "lib/models.rb",
     "lib/pratt.rb",
     "lib/pratt/core_ext.rb",
     "lib/pratt/core_ext/array.rb",
     "lib/pratt/core_ext/float.rb",
     "lib/pratt/core_ext/nil.rb",
     "lib/pratt/core_ext/numeric.rb",
     "lib/pratt/core_ext/string.rb",
     "lib/pratt/core_ext/time.rb",
     "lib/pratt/dialogs.rb",
     "lib/pratt/formatting.rb",
     "lib/pratt/project_actions.rb",
     "lib/pratt/reports.rb",
     "models/app.rb",
     "models/customer.rb",
     "models/invoice.rb",
     "models/invoice_whence.rb",
     "models/payment.rb",
     "models/pratt.rb",
     "models/project.rb",
     "models/whence.rb",
     "models/zip.rb",
     "pkgs/tile-0.8.2.tar.gz",
     "pkgs/tile-0.8.2/ANNOUNCE.txt",
     "pkgs/tile-0.8.2/ChangeLog",
     "pkgs/tile-0.8.2/Makefile",
     "pkgs/tile-0.8.2/Makefile.in",
     "pkgs/tile-0.8.2/README.txt",
     "pkgs/tile-0.8.2/aclocal.m4",
     "pkgs/tile-0.8.2/altTheme.o",
     "pkgs/tile-0.8.2/blink.o",
     "pkgs/tile-0.8.2/button.o",
     "pkgs/tile-0.8.2/cache.o",
     "pkgs/tile-0.8.2/clamTheme.o",
     "pkgs/tile-0.8.2/classicTheme.o",
     "pkgs/tile-0.8.2/config.log",
     "pkgs/tile-0.8.2/config.status",
     "pkgs/tile-0.8.2/configure",
     "pkgs/tile-0.8.2/configure.in",
     "pkgs/tile-0.8.2/demos/autocomplete.tcl",
     "pkgs/tile-0.8.2/demos/demo.tcl",
     "pkgs/tile-0.8.2/demos/dirbrowser.tcl",
     "pkgs/tile-0.8.2/demos/dlgtest.tcl",
     "pkgs/tile-0.8.2/demos/iconlib.tcl",
     "pkgs/tile-0.8.2/demos/repeater.tcl",
     "pkgs/tile-0.8.2/demos/toolbutton.tcl",
     "pkgs/tile-0.8.2/doc/Geometry.3",
     "pkgs/tile-0.8.2/doc/INDEX.MAP",
     "pkgs/tile-0.8.2/doc/Makefile",
     "pkgs/tile-0.8.2/doc/TILE.XML",
     "pkgs/tile-0.8.2/doc/Theme.3",
     "pkgs/tile-0.8.2/doc/button.n",
     "pkgs/tile-0.8.2/doc/checkbutton.n",
     "pkgs/tile-0.8.2/doc/combobox.n",
     "pkgs/tile-0.8.2/doc/converting.txt",
     "pkgs/tile-0.8.2/doc/dialog.n",
     "pkgs/tile-0.8.2/doc/entry.n",
     "pkgs/tile-0.8.2/doc/frame.n",
     "pkgs/tile-0.8.2/doc/html/Geometry.html",
     "pkgs/tile-0.8.2/doc/html/Theme.html",
     "pkgs/tile-0.8.2/doc/html/button.html",
     "pkgs/tile-0.8.2/doc/html/category-index.html",
     "pkgs/tile-0.8.2/doc/html/checkbutton.html",
     "pkgs/tile-0.8.2/doc/html/combobox.html",
     "pkgs/tile-0.8.2/doc/html/converting.txt",
     "pkgs/tile-0.8.2/doc/html/dialog.html",
     "pkgs/tile-0.8.2/doc/html/entry.html",
     "pkgs/tile-0.8.2/doc/html/frame.html",
     "pkgs/tile-0.8.2/doc/html/image.html",
     "pkgs/tile-0.8.2/doc/html/index.html",
     "pkgs/tile-0.8.2/doc/html/keyword-index.html",
     "pkgs/tile-0.8.2/doc/html/label.html",
     "pkgs/tile-0.8.2/doc/html/labelframe.html",
     "pkgs/tile-0.8.2/doc/html/manpage.css",
     "pkgs/tile-0.8.2/doc/html/menubutton.html",
     "pkgs/tile-0.8.2/doc/html/notebook.html",
     "pkgs/tile-0.8.2/doc/html/paned.html",
     "pkgs/tile-0.8.2/doc/html/progressbar.html",
     "pkgs/tile-0.8.2/doc/html/radiobutton.html",
     "pkgs/tile-0.8.2/doc/html/scrollbar.html",
     "pkgs/tile-0.8.2/doc/html/separator.html",
     "pkgs/tile-0.8.2/doc/html/sizegrip.html",
     "pkgs/tile-0.8.2/doc/html/style.html",
     "pkgs/tile-0.8.2/doc/html/tile-intro.html",
     "pkgs/tile-0.8.2/doc/html/treeview.html",
     "pkgs/tile-0.8.2/doc/html/widget.html",
     "pkgs/tile-0.8.2/doc/image.n",
     "pkgs/tile-0.8.2/doc/internals.txt",
     "pkgs/tile-0.8.2/doc/label.n",
     "pkgs/tile-0.8.2/doc/labelframe.n",
     "pkgs/tile-0.8.2/doc/man.macros",
     "pkgs/tile-0.8.2/doc/menubutton.n",
     "pkgs/tile-0.8.2/doc/notebook.n",
     "pkgs/tile-0.8.2/doc/paned.n",
     "pkgs/tile-0.8.2/doc/progressbar.n",
     "pkgs/tile-0.8.2/doc/radiobutton.n",
     "pkgs/tile-0.8.2/doc/scrollbar.n",
     "pkgs/tile-0.8.2/doc/separator.n",
     "pkgs/tile-0.8.2/doc/sizegrip.n",
     "pkgs/tile-0.8.2/doc/style.n",
     "pkgs/tile-0.8.2/doc/tile-intro.n",
     "pkgs/tile-0.8.2/doc/tmml.options",
     "pkgs/tile-0.8.2/doc/treeview.n",
     "pkgs/tile-0.8.2/doc/widget.n",
     "pkgs/tile-0.8.2/doc/xml/Geometry.tmml",
     "pkgs/tile-0.8.2/doc/xml/INDEX.MAP",
     "pkgs/tile-0.8.2/doc/xml/Theme.tmml",
     "pkgs/tile-0.8.2/doc/xml/button.tmml",
     "pkgs/tile-0.8.2/doc/xml/checkbutton.tmml",
     "pkgs/tile-0.8.2/doc/xml/combobox.tmml",
     "pkgs/tile-0.8.2/doc/xml/dialog.tmml",
     "pkgs/tile-0.8.2/doc/xml/entry.tmml",
     "pkgs/tile-0.8.2/doc/xml/frame.tmml",
     "pkgs/tile-0.8.2/doc/xml/image.tmml",
     "pkgs/tile-0.8.2/doc/xml/label.tmml",
     "pkgs/tile-0.8.2/doc/xml/labelframe.tmml",
     "pkgs/tile-0.8.2/doc/xml/menubutton.tmml",
     "pkgs/tile-0.8.2/doc/xml/notebook.tmml",
     "pkgs/tile-0.8.2/doc/xml/paned.tmml",
     "pkgs/tile-0.8.2/doc/xml/progressbar.tmml",
     "pkgs/tile-0.8.2/doc/xml/radiobutton.tmml",
     "pkgs/tile-0.8.2/doc/xml/scrollbar.tmml",
     "pkgs/tile-0.8.2/doc/xml/separator.tmml",
     "pkgs/tile-0.8.2/doc/xml/sizegrip.tmml",
     "pkgs/tile-0.8.2/doc/xml/style.tmml",
     "pkgs/tile-0.8.2/doc/xml/tile-intro.tmml",
     "pkgs/tile-0.8.2/doc/xml/treeview.tmml",
     "pkgs/tile-0.8.2/doc/xml/widget.tmml",
     "pkgs/tile-0.8.2/entry.o",
     "pkgs/tile-0.8.2/frame.o",
     "pkgs/tile-0.8.2/generic/Makefile.in",
     "pkgs/tile-0.8.2/generic/TODO",
     "pkgs/tile-0.8.2/generic/altTheme.c",
     "pkgs/tile-0.8.2/generic/blink.c",
     "pkgs/tile-0.8.2/generic/button.c",
     "pkgs/tile-0.8.2/generic/cache.c",
     "pkgs/tile-0.8.2/generic/clamTheme.c",
     "pkgs/tile-0.8.2/generic/classicTheme.c",
     "pkgs/tile-0.8.2/generic/configure",
     "pkgs/tile-0.8.2/generic/configure.in",
     "pkgs/tile-0.8.2/generic/entry.c",
     "pkgs/tile-0.8.2/generic/frame.c",
     "pkgs/tile-0.8.2/generic/gunk.h",
     "pkgs/tile-0.8.2/generic/image.c",
     "pkgs/tile-0.8.2/generic/label.c",
     "pkgs/tile-0.8.2/generic/layout.c",
     "pkgs/tile-0.8.2/generic/manager.c",
     "pkgs/tile-0.8.2/generic/manager.h",
     "pkgs/tile-0.8.2/generic/notebook.c",
     "pkgs/tile-0.8.2/generic/paned.c",
     "pkgs/tile-0.8.2/generic/pkgIndex.tcl.in",
     "pkgs/tile-0.8.2/generic/progress.c",
     "pkgs/tile-0.8.2/generic/scale.c",
     "pkgs/tile-0.8.2/generic/scroll.c",
     "pkgs/tile-0.8.2/generic/scrollbar.c",
     "pkgs/tile-0.8.2/generic/separator.c",
     "pkgs/tile-0.8.2/generic/square.c",
     "pkgs/tile-0.8.2/generic/tagset.c",
     "pkgs/tile-0.8.2/generic/tile.c",
     "pkgs/tile-0.8.2/generic/tkElements.c",
     "pkgs/tile-0.8.2/generic/tkTheme.c",
     "pkgs/tile-0.8.2/generic/tkTheme.h",
     "pkgs/tile-0.8.2/generic/tkThemeInt.h",
     "pkgs/tile-0.8.2/generic/tkstate.c",
     "pkgs/tile-0.8.2/generic/trace.c",
     "pkgs/tile-0.8.2/generic/track.c",
     "pkgs/tile-0.8.2/generic/treeview.c",
     "pkgs/tile-0.8.2/generic/ttk.decls",
     "pkgs/tile-0.8.2/generic/ttkDecls.h",
     "pkgs/tile-0.8.2/generic/ttkStubInit.c",
     "pkgs/tile-0.8.2/generic/ttkStubLib.c",
     "pkgs/tile-0.8.2/generic/widget.c",
     "pkgs/tile-0.8.2/generic/widget.h",
     "pkgs/tile-0.8.2/image.o",
     "pkgs/tile-0.8.2/label.o",
     "pkgs/tile-0.8.2/layout.o",
     "pkgs/tile-0.8.2/library/altTheme.tcl",
     "pkgs/tile-0.8.2/library/aquaTheme.tcl",
     "pkgs/tile-0.8.2/library/button.tcl",
     "pkgs/tile-0.8.2/library/clamTheme.tcl",
     "pkgs/tile-0.8.2/library/classicTheme.tcl",
     "pkgs/tile-0.8.2/library/combobox.tcl",
     "pkgs/tile-0.8.2/library/cursors.tcl",
     "pkgs/tile-0.8.2/library/defaults.tcl",
     "pkgs/tile-0.8.2/library/dialog.tcl",
     "pkgs/tile-0.8.2/library/entry.tcl",
     "pkgs/tile-0.8.2/library/fonts.tcl",
     "pkgs/tile-0.8.2/library/icons.tcl",
     "pkgs/tile-0.8.2/library/keynav.tcl",
     "pkgs/tile-0.8.2/library/menubutton.tcl",
     "pkgs/tile-0.8.2/library/notebook.tcl",
     "pkgs/tile-0.8.2/library/paned.tcl",
     "pkgs/tile-0.8.2/library/progress.tcl",
     "pkgs/tile-0.8.2/library/scale.tcl",
     "pkgs/tile-0.8.2/library/scrollbar.tcl",
     "pkgs/tile-0.8.2/library/sizegrip.tcl",
     "pkgs/tile-0.8.2/library/tile.tcl",
     "pkgs/tile-0.8.2/library/treeview.tcl",
     "pkgs/tile-0.8.2/library/utils.tcl",
     "pkgs/tile-0.8.2/library/winTheme.tcl",
     "pkgs/tile-0.8.2/library/xpTheme.tcl",
     "pkgs/tile-0.8.2/libtile0.8.2.so",
     "pkgs/tile-0.8.2/libttkstub.a",
     "pkgs/tile-0.8.2/license.terms",
     "pkgs/tile-0.8.2/macosx/aquaTheme.c",
     "pkgs/tile-0.8.2/manager.o",
     "pkgs/tile-0.8.2/notebook.o",
     "pkgs/tile-0.8.2/paned.o",
     "pkgs/tile-0.8.2/pkgIndex.tcl",
     "pkgs/tile-0.8.2/progress.o",
     "pkgs/tile-0.8.2/scale.o",
     "pkgs/tile-0.8.2/scroll.o",
     "pkgs/tile-0.8.2/scrollbar.o",
     "pkgs/tile-0.8.2/separator.o",
     "pkgs/tile-0.8.2/tagset.o",
     "pkgs/tile-0.8.2/tclconfig/install-sh",
     "pkgs/tile-0.8.2/tclconfig/tcl.m4",
     "pkgs/tile-0.8.2/tclconfig/teax.m4",
     "pkgs/tile-0.8.2/tests/all.tcl",
     "pkgs/tile-0.8.2/tests/bwidget.test",
     "pkgs/tile-0.8.2/tests/cbtest.tcl",
     "pkgs/tile-0.8.2/tests/combobox.test",
     "pkgs/tile-0.8.2/tests/compound.tcl",
     "pkgs/tile-0.8.2/tests/entry.test",
     "pkgs/tile-0.8.2/tests/entrytest.tcl",
     "pkgs/tile-0.8.2/tests/image.test",
     "pkgs/tile-0.8.2/tests/labelframe.tcl",
     "pkgs/tile-0.8.2/tests/labelframe.test",
     "pkgs/tile-0.8.2/tests/layout.test",
     "pkgs/tile-0.8.2/tests/misc.test",
     "pkgs/tile-0.8.2/tests/nbtest.tcl",
     "pkgs/tile-0.8.2/tests/notebook.test",
     "pkgs/tile-0.8.2/tests/paned.test",
     "pkgs/tile-0.8.2/tests/progress.test",
     "pkgs/tile-0.8.2/tests/pwtest.tcl",
     "pkgs/tile-0.8.2/tests/sbtest.tcl",
     "pkgs/tile-0.8.2/tests/scrollbar.test",
     "pkgs/tile-0.8.2/tests/sgtest.tcl",
     "pkgs/tile-0.8.2/tests/testutils.tcl",
     "pkgs/tile-0.8.2/tests/tile.test",
     "pkgs/tile-0.8.2/tests/treetags.test",
     "pkgs/tile-0.8.2/tests/treeview.test",
     "pkgs/tile-0.8.2/tests/tvtest.tcl",
     "pkgs/tile-0.8.2/tests/validate.test",
     "pkgs/tile-0.8.2/tile.o",
     "pkgs/tile-0.8.2/tkElements.o",
     "pkgs/tile-0.8.2/tkTheme.o",
     "pkgs/tile-0.8.2/tkstate.o",
     "pkgs/tile-0.8.2/tools/genStubs.tcl",
     "pkgs/tile-0.8.2/trace.o",
     "pkgs/tile-0.8.2/track.o",
     "pkgs/tile-0.8.2/treeview.o",
     "pkgs/tile-0.8.2/ttkStubInit.o",
     "pkgs/tile-0.8.2/ttkStubLib.o",
     "pkgs/tile-0.8.2/widget.o",
     "pkgs/tile-0.8.2/win/Tile.dsp",
     "pkgs/tile-0.8.2/win/makefile.vc",
     "pkgs/tile-0.8.2/win/monitor.c",
     "pkgs/tile-0.8.2/win/nmakehlp.c",
     "pkgs/tile-0.8.2/win/rules.vc",
     "pkgs/tile-0.8.2/win/tile.rc",
     "pkgs/tile-0.8.2/win/winTheme.c",
     "pkgs/tile-0.8.2/win/xpTheme.c",
     "pkgs/tktray1.2.tar.gz",
     "pratt.mm",
     "reports/travel.log",
     "reports/travel.log.2009",
     "spec/app_spec.rb",
     "spec/customer_spec.rb",
     "spec/fixtures/graph.expectation",
     "spec/fixtures/proportions.expectation",
     "spec/float_spec.rb",
     "spec/numeric_spec.rb",
     "spec/payment_spec.rb",
     "spec/pratt_spec.rb",
     "spec/project_spec.rb",
     "spec/rcov.opts",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/string_ext_spec.rb",
     "spec/whence_spec.rb",
     "tasks/pratt.rb",
     "templates/model.eruby",
     "templates/spec.eruby",
     "views/current.eruby",
     "views/general-invoice.eruby",
     "views/graph.eruby",
     "views/invoice.eruby",
     "views/main.rb",
     "views/pid.eruby",
     "views/pop.rb",
     "views/proportions.eruby",
     "views/raw.eruby"
  ]
  s.homepage = %q{http://github.com/frogstarr78/pratt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{Pratt}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Pro/Re-Active Time Tracker.  Track time based on what you expect to be working on, with frequent prompts to ensure accuracy.}
  s.test_files = [
    "spec/whence_spec.rb",
     "spec/spec_helper.rb",
     "spec/float_spec.rb",
     "spec/pratt_spec.rb",
     "spec/project_spec.rb",
     "spec/numeric_spec.rb",
     "spec/app_spec.rb",
     "spec/string_ext_spec.rb",
     "spec/customer_spec.rb",
     "spec/payment_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_runtime_dependency(%q<activerecord>, [">= 2.1.1"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, [">= 1.2.4"])
      s.add_runtime_dependency(%q<shifty_week>, [">= 0.1.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_dependency(%q<activerecord>, [">= 2.1.1"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 1.2.4"])
      s.add_dependency(%q<shifty_week>, [">= 0.1.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.6"])
    s.add_dependency(%q<mocha>, [">= 0.9.5"])
    s.add_dependency(%q<activerecord>, [">= 2.1.1"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 1.2.4"])
    s.add_dependency(%q<shifty_week>, [">= 0.1.0"])
  end
end

