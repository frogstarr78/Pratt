= pratt

* Pratt (url)

== DESCRIPTION:

Pratt (Pro/Re)-Active Time Tracker

== FEATURES/PROBLEMS:

(list of features or problems)
* Currently you'll need to manually fix the project data since I haven't
fully integrated the support for Projects to have a Customer.
* Upgrading versions looses your database. (See TODO)
* Windows doesn't work (no fork). (See TODO)


== SYNOPSIS:

* pratt (code sample of usage)

** PRATT_ENV=production pratt -D # daemonize (or if already daemonized init the
gui)
** pratt -h (as you'd expect lists available commands)

== REQUIREMENTS:

* pratt 
debian: libtcltk-ruby tk-tile libsqlite3-dev
gems: activerecord sqlite3-ruby rspec mocha
tk: http://sourceforge.net/project/showfiles.php?group_id=11464&package_id=107795&release_id=562098

== INSTALL:

* sudo gem install

Credits

Michael Goff
	Thanks for helping me with some of the workflow details
Michael and Kent Krenrich
	Thanks for the UI input, suggestions, and testing.

== LICENSE:

(The MIT License)

Copyright (c) 2009 Frogstarr78 Software

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
