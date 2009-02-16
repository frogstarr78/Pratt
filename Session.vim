let SessionLoad = 1
if &cp | set nocp | endif
map 	 
map ; :
map Q gq
map UU :call UnComment()
vmap [% [%m'gv``
map \t :TestMe
map \c :w!:CTagsRun
map \i :w!:Runme -i
map \rd :w!:Runme -d
map \ru :w!:Runme -u
map \rf :w!:Runme -f
map \rt :w!:Runme -t
map \r :w!:Runme
map \ac :call Comment(";") " asterisk config comment
map \bc :call Comment("r") " batch file comment
map \vc :call Comment("\"") " vim comment
map \jc :call Comment("/") " javascript comment
map \sc :call Comment("-") " sql comment
map \mc :call Comment("*") " C-type multi-line comment
map \hc :call Comment("!") " html comment
map \pc :call Comment("#") " p* language comment
map \cc :call FComment()
map \a :execute histget("cmd", -1)
vmap ]% ]%m'gv``
vmap a% [%v]%
map bn :bn
map bp :bp
map co :!gmcs %
let s:cpo_save=&cpo
set cpo&vim
map e <S-Right>
nmap gx <Plug>NetrwBrowseX
map mm :!mono %:r.exe
map qq :qa!
map q :wq!
map s :w
map sb :sb
map zz :w
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
imap 	   
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1,default
set helplang=en
set hlsearch
set ruler
set runtimepath=~/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,~/.vim/after,~/svn/devscripts/vim/.vim/
set shiftwidth=2
set softtabstop=4
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
set tabstop=2
set tags=./tags,./TAGS,tags,TAGS,~/ctags/tags,~/ctags/java.tags
set timeoutlen=500
set viminfo=!,'20,<50,s10,h
set wildmenu
set wildmode=list:longest,full
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/git/pratt
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +21 lib/pratt.rb
badd +2 bin/pratt.rb
badd +7 lib/complex.rb
badd +25 lib/binary.rb
badd +14 models/whence.rb
badd +34 config.rb
badd +18 Rakefile
badd +188 /usr/lib/ruby/1.8/pathname.rb
badd +41 ../rebuild_tracker/tracker.rb
badd +1 ../rebuild_tracker/simple.tcl
badd +45 ../rebuild_tracker/binary.rb
badd +65 models/project.rb
badd +0 models/pref.rb
args lib/pratt.rb bin/pratt
edit ../rebuild_tracker/simple.tcl
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 24 + 38) / 76)
exe '2resize ' . ((&lines * 24 + 38) / 76)
exe '3resize ' . ((&lines * 24 + 38) / 76)
argglobal
edit ../rebuild_tracker/simple.tcl
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'tcl'
setlocal filetype=tcl
endif
set foldcolumn=3
setlocal foldcolumn=3
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'tcl'
setlocal syntax=tcl
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 30 - ((10 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
30
normal! 0
wincmd w
argglobal
edit lib/pratt.rb
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*#\\s*define
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
set foldcolumn=3
setlocal foldcolumn=3
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,/usr/lib/ruby/site_ruby/1.8,/usr/lib/ruby/site_ruby/1.8/i686-linux,/usr/lib/ruby/site_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i686-linux,,/usr/lib/ruby/gems/1.8/gems/Text-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/chronic-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/colored-1.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.0/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/fastercsv-1.4.0/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.1/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.1/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/hoe-1.8.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/mongrel_cluster-1.0.5/lib,/usr/lib/ruby/gems/1.8/gems/passenger-2.0.6/lib/ext,/usr/lib/ruby/gems/1.8/gems/postgres-0.7.9.2008.01.28/lib,/usr/lib/ruby/gems/1.8/gems/rack-0.9.1/lib,/usr/lib/ruby/gems/1.8/gems/rails-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/rake-0.8.3/lib,/usr/lib/ruby/gems/1.8/gems/rcov-0.8.1.2.0/lib,/usr/lib/ruby/gems/1.8/gems/ruby-debug-0.10.3/cli,/usr/lib/ruby/gems/1.8/gems/ruby-debug-base-0.10.3/lib,/usr/lib/ruby/gems/1.8/gems/rubyforge-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/runt-0.7.0/lib,/usr/lib/ruby/gems/1.8/gems/sqlite3-ruby-1.2.4/lib,/usr/lib/ruby/gems/1.8/gems/will_paginate-2.2.2/lib
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
3
normal zo
4
normal zo
7
normal zo
10
normal zo
10
normal zo
7
normal zo
3
normal zo
12
normal zo
17
normal zo
18
normal zo
23
normal zo
18
normal zo
17
normal zo
12
normal zo
let s:l = 2 - ((1 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 0
wincmd w
argglobal
edit lib/binary.rb
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*#\\s*define
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
set foldcolumn=3
setlocal foldcolumn=3
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=syntax
setlocal foldmethod=syntax
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,/usr/lib/ruby/site_ruby/1.8,/usr/lib/ruby/site_ruby/1.8/i686-linux,/usr/lib/ruby/site_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i686-linux,,/usr/lib/ruby/gems/1.8/gems/Text-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/chronic-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/colored-1.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.0/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/fastercsv-1.4.0/lib,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.1/ext,/usr/lib/ruby/gems/1.8/gems/fastthread-1.0.1/lib,/usr/lib/ruby/gems/1.8/gems/gem_plugin-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/hoe-1.8.3/lib,/usr/lib/ruby/gems/1.8/gems/linecache-0.43/lib,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/ext,/usr/lib/ruby/gems/1.8/gems/mongrel-1.1.5/lib,/usr/lib/ruby/gems/1.8/gems/mongrel_cluster-1.0.5/lib,/usr/lib/ruby/gems/1.8/gems/passenger-2.0.6/lib/ext,/usr/lib/ruby/gems/1.8/gems/postgres-0.7.9.2008.01.28/lib,/usr/lib/ruby/gems/1.8/gems/rack-0.9.1/lib,/usr/lib/ruby/gems/1.8/gems/rails-2.2.2/lib,/usr/lib/ruby/gems/1.8/gems/rake-0.8.3/lib,/usr/lib/ruby/gems/1.8/gems/rcov-0.8.1.2.0/lib,/usr/lib/ruby/gems/1.8/gems/ruby-debug-0.10.3/cli,/usr/lib/ruby/gems/1.8/gems/ruby-debug-base-0.10.3/lib,/usr/lib/ruby/gems/1.8/gems/rubyforge-1.0.2/lib,/usr/lib/ruby/gems/1.8/gems/runt-0.7.0/lib,/usr/lib/ruby/gems/1.8/gems/sqlite3-ruby-1.2.4/lib,/usr/lib/ruby/gems/1.8/gems/will_paginate-2.2.2/lib
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
4
normal zo
12
normal zo
16
normal zo
20
normal zo
22
normal zo
20
normal zo
28
normal zo
30
normal zo
34
normal zo
30
normal zo
28
normal zo
let s:l = 40 - ((21 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
40
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 24 + 38) / 76)
exe '2resize ' . ((&lines * 24 + 38) / 76)
exe '3resize ' . ((&lines * 24 + 38) / 76)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . s:sx
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
