let SessionLoad = 1
if &cp | set nocp | endif
map 	 
nmap  :call Toggle()
vmap  :call Toggle()
map ; :
map Q gq
map UU :call UnComment()
vmap [% [%m'gv``
map \b :call g:RubyDebugger.toggle_breakpoint()
map \v :call g:RubyDebugger.open_variables()
map \m :call g:RubyDebugger.open_breakpoints()
map \s :call g:RubyDebugger.step()
map \n :call g:RubyDebugger.next()
map \c :call g:RubyDebugger.continue()
map \e :call g:RubyDebugger.exit()
map \a :execute histget("cmd", -1)
map \r :w!:Runme
map \rt :w!:Runme -t
map \ru :w!:Runme -u
map \rd :w!:Runme -d
map \i :w!:Runme -i
map \t :TestMe
map \ac :call Comment(";") " asterisk config comment
map \bc :call Comment("r") " batch file comment
map \vc :call Comment("\"") " vim comment
map \jc :call Comment("/") " javascript comment
map \sc :call Comment("-") " sql comment
map \mc :call Comment("*") " C-type multi-line comment
map \hc :call Comment("!") " html comment
map \pc :call Comment("#") " p* language comment
map \cc :call FComment()
vmap ]% ]%m'gv``
vmap a% [%v]%
map bp :bp
map bn :bn
map co :CompileMe
let s:cpo_save=&cpo
set cpo&vim
map e <S-Right>
nmap gx <Plug>NetrwBrowseX
map q :wq!
map qq :qa!
map sb :sb
map s :w
map zz :w
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
imap 	   
imap  :call Toggle()
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=2
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1,default
set helplang=en
set hlsearch
set ruler
set runtimepath=~/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,~/.vim/after,~/svn/devscripts/vim/.vim/
set shiftwidth=2
set softtabstop=2
set spelllang=en_us
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
set tabstop=2
set tags=./tags,./TAGS,tags,TAGS,~/ctags/tags,~/ctags/java.tags
set timeoutlen=500
set viminfo=!,'100,<50,s10,h
set wildmenu
set wildmode=list:longest,full
set window=77
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/git/pratt
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 lib/pratt.rb
badd +8 views/env.rb
badd +1 views/customer.rb
badd +24 views/main.rb
badd +10 views/pop.rb
badd +0 views/pop2.rb
badd +9 views/base.rb
badd +2 config.rb
badd +3 models/pratt.rb
badd +0 ~/git/sandbox/ruby/tk.rb
badd +55 models/project.rb
args lib/pratt.rb
edit lib/pratt.rb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 93 + 139) / 279)
exe 'vert 2resize ' . ((&columns * 92 + 139) / 279)
exe 'vert 3resize ' . ((&columns * 92 + 139) / 279)
argglobal
inoremap <buffer> \> >
inoremap <buffer> \. >
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
setlocal errorformat=%+W###\ %f:%l,%-C\ \ \ ,%-C!!\ 
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
setlocal makeprg=rake\ $*\ RCOVOPTS=\"-D\ --no-html\ --no-color\"\ $*
setlocal matchpairs=(:),{:},[:],<:>
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
setlocal softtabstop=2
setlocal spell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
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
35
normal zo
41
normal zo
63
normal zo
76
normal zo
79
normal zo
80
normal zo
79
normal zo
88
normal zo
93
normal zo
99
normal zo
103
normal zo
111
normal zo
103
normal zo
119
normal zo
99
normal zo
127
normal zo
130
normal zo
138
normal zo
130
normal zo
144
normal zo
147
normal zo
127
normal zo
154
normal zo
161
normal zo
164
normal zo
168
normal zo
175
normal zo
164
normal zo
161
normal zo
182
normal zo
185
normal zo
186
normal zo
185
normal zo
192
normal zo
193
normal zo
192
normal zo
199
normal zo
202
normal zo
206
normal zo
210
normal zo
215
normal zo
218
normal zo
221
normal zo
218
normal zo
215
normal zo
236
normal zo
239
normal zo
236
normal zo
248
normal zo
249
normal zo
248
normal zo
257
normal zo
258
normal zo
257
normal zo
265
normal zo
269
normal zo
270
normal zo
269
normal zo
277
normal zo
281
normal zo
309
normal zo
312
normal zo
313
normal zo
319
normal zo
313
normal zo
312
normal zo
327
normal zo
332
normal zo
336
normal zo
344
normal zo
332
normal zo
351
normal zo
359
normal zo
363
normal zo
367
normal zo
373
normal zo
377
normal zo
383
normal zo
386
normal zo
391
normal zo
395
normal zo
399
normal zo
404
normal zo
407
normal zo
414
normal zo
418
normal zo
421
normal zo
425
normal zo
428
normal zo
431
normal zo
434
normal zo
437
normal zo
440
normal zo
444
normal zo
447
normal zo
450
normal zo
453
normal zo
456
normal zo
459
normal zo
462
normal zo
465
normal zo
471
normal zo
473
normal zo
480
normal zo
484
normal zo
490
normal zo
495
normal zo
500
normal zo
503
normal zo
506
normal zo
509
normal zo
414
normal zo
404
normal zo
525
normal zo
529
normal zo
534
normal zo
536
normal zo
538
normal zo
544
normal zo
536
normal zo
552
normal zo
557
normal zo
558
normal zo
561
normal zo
558
normal zo
557
normal zo
569
normal zo
383
normal zo
35
normal zo
let s:l = 261 - ((37 * winheight(0) + 38) / 76)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
261
normal! 027l
wincmd w
argglobal
edit ~/git/sandbox/ruby/tk.rb
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
setlocal define=
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
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
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
setlocal path=.,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/lib,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby/1.8/i686-linux,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby/1.8/i686-linux,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/i686-linux,,~/.rvm/gems/ruby-1.8.7-p249/gems/MP4Info-0.3.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/Rack-2.0.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionmailer-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionmailer-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activeresource-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activeresource-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/awesome_print-0.1.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/builder-2.1.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/bundler-0.9.14/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/colored-1.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/columnize-0.3.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/daemons-1.0.10/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/eventmachine-0.12.10/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/flacinfo-rb-0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/fxruby-1.6.20-x86-linux/ext/fox16,~/.rvm/gems/ruby-1.8.7-p249/gems/fxruby-1.6.20-x86-linux/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/git-1.2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/i18n-0.3.6/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/jeweler-1.4.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/linecache-0.43/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/multi-0.1/.,~/.rvm/gems/ruby-1.8.7-p249/gems/polyglot-0.3.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.0.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.1.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rdoc-2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rdoc-data-2.5.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rspec-1.3.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-audioinfo-0.1.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-debug-0.10.3/cli,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-debug-base-0.10.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-mp3info-0.6.13/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-ogginfo-0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rubyforge-2.0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rubygems-update-1.3.6/hide_lib_for_update,~/.rvm/gems/ruby-1.8.7-p249/gems/shoulda-2.10.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/ext,~/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/thin-1.2.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/treetop-1.4.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/twiliolib-2.0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/wmainfo-rb-0.6/lib,~/.rvm/gems/ruby-1.8.7-p249@global/gems/rake-0.8.7/lib
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
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
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
6
normal zc
9
normal zc
51
normal zo
54
normal zo
55
normal zo
70
normal zo
78
normal zo
84
normal zo
55
normal zo
54
normal zo
93
normal zo
96
normal zo
101
normal zo
105
normal zo
106
normal zo
109
normal zo
106
normal zo
105
normal zo
96
normal zo
93
normal zo
let s:l = 134 - ((75 * winheight(0) + 38) / 76)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
134
normal! 010l
wincmd w
argglobal
edit views/pop2.rb
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
setlocal define=
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
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
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
setlocal path=.,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/bin,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/lib,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby/1.8/i686-linux,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/site_ruby,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby/1.8/i686-linux,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/vendor_ruby,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8,~/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/i686-linux,,~/.rvm/gems/ruby-1.8.7-p249/gems/MP4Info-0.3.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/Rack-2.0.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionmailer-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionmailer-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activeresource-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activeresource-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/awesome_print-0.1.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/builder-2.1.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/bundler-0.9.14/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/colored-1.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/columnize-0.3.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/crack-0.1.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/daemons-1.0.10/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/eventmachine-0.12.10/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/flacinfo-rb-0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/fxruby-1.6.20-x86-linux/ext/fox16,~/.rvm/gems/ruby-1.8.7-p249/gems/fxruby-1.6.20-x86-linux/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemcutter-0.5.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/gemwhois-0.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/git-1.2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/i18n-0.3.6/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/jeweler-1.4.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/linecache-0.43/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/multi-0.1/.,~/.rvm/gems/ruby-1.8.7-p249/gems/polyglot-0.3.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.0.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.1.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.2/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rdoc-2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rdoc-data-2.5.1/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rspec-1.3.0/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-audioinfo-0.1.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-debug-0.10.3/cli,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-debug-base-0.10.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-mp3info-0.6.13/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/ruby-ogginfo-0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rubyforge-2.0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/rubygems-update-1.3.6/hide_lib_for_update,~/.rvm/gems/ruby-1.8.7-p249/gems/shoulda-2.10.3/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/ext,~/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/thin-1.2.7/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/treetop-1.4.5/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/twiliolib-2.0.4/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/unindent-0.9/lib,~/.rvm/gems/ruby-1.8.7-p249/gems/wmainfo-rb-0.6/lib,~/.rvm/gems/ruby-1.8.7-p249@global/gems/rake-0.8.7/lib
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
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en_us
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
5
normal zo
6
normal zo
10
normal zo
19
normal zo
23
normal zo
24
normal zo
23
normal zo
28
normal zo
29
normal zo
28
normal zo
38
normal zo
44
normal zo
48
normal zo
52
normal zo
56
normal zo
57
normal zo
56
normal zo
64
normal zo
69
normal zo
71
normal zo
69
normal zo
64
normal zo
71
normal zo
44
normal zo
6
normal zo
5
normal zo
let s:l = 66 - ((55 * winheight(0) + 38) / 76)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
66
normal! 018l
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 139) / 279)
exe 'vert 2resize ' . ((&columns * 92 + 139) / 279)
exe 'vert 3resize ' . ((&columns * 92 + 139) / 279)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
