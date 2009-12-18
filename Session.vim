let SessionLoad = 1
if &cp | set nocp | endif
map 	 
vmap  :call Toggle()
nmap  :call Toggle()
map ; :
map Q gq
map UU :call UnComment()
vmap [% [%m'gv``
map \t :TestMe
map \i :w!:Runme -i
map \rd :w!:Runme -d
map \ru :w!:Runme -u
map \rt :w!:Runme -t
map \r :w!:Runme
map \a :execute histget("cmd", -1)
map \ac :call Comment(";") " asterisk config comment
map \bc :call Comment("r") " batch file comment
map \vc :call Comment("\"") " vim comment
map \jc :call Comment("/") " javascript comment
map \sc :call Comment("-") " sql comment
map \mc :call Comment("*") " C-type multi-line comment
map \hc :call Comment("!") " html comment
map \pc :call Comment("#") " p* language comment
map \cc :call FComment()
map \e :call g:RubyDebugger.exit()
map \c :call g:RubyDebugger.continue()
map \n :call g:RubyDebugger.next()
map \s :call g:RubyDebugger.step()
map \m :call g:RubyDebugger.open_breakpoints()
map \v :call g:RubyDebugger.open_variables()
map \b :call g:RubyDebugger.toggle_breakpoint()
vmap ]% ]%m'gv``
vmap a% [%v]%
map bn :bn
map bp :bp
map co :CompileMe
let s:cpo_save=&cpo
set cpo&vim
map e <S-Right>
nmap gx <Plug>NetrwBrowseX
map qq :qa!
map q :wq!
map s :w
map sb :sb
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
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
set tabstop=2
set tags=./tags,./TAGS,tags,TAGS,~/ctags/tags,~/ctags/java.tags
set timeoutlen=500
set viminfo=!,'100,<50,s10,h
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
badd +1 lib/pratt.rb
badd +8 views/env.rb
badd +1 views/customer.rb
badd +1 views/main.rb
badd +1 views/pop.rb
args lib/pratt.rb
edit views/pop.rb
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 1resize ' . ((&columns * 93 + 140) / 280)
exe '2resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 2resize ' . ((&columns * 92 + 140) / 280)
exe '3resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 3resize ' . ((&columns * 93 + 140) / 280)
exe '4resize ' . ((&lines * 37 + 38) / 77)
argglobal
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
setlocal path=.,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.6/lib,/usr/lib/ruby/site_ruby/1.8,/usr/lib/ruby/site_ruby/1.8/i686-linux,/usr/lib/ruby/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i686-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i686-linux,,~/.gem/ruby/1.8/gems/Pratt-1.5.8/lib,~/.gem/ruby/1.8/gems/anvil-0.0.1/lib,~/.gem/ruby/1.8/gems/facets-2.7.0/lib,~/.gem/ruby/1.8/gems/shifty_week-0.1.1/lib,~/.gem/ruby/1.8/gems/treetop-1.4.2/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/Linguistics-1.0.5/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Text-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/acts_as_reportable-1.1.1/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.0.2/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/archive-tar-minitar-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/aws-s3-0.6.2/lib,/usr/lib/ruby/gems/1.8/gems/bluecloth-2.0.5/lib,/usr/lib/ruby/gems/1.8/gems/bones-2.5.1/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/case-0.5/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/chronic-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/color-1.4.0/lib,/usr/lib/ruby/gems/1.8/gems/colored-1.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/crack-0.1.4/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-dm-rest-adapter-0.9.12/lib,/usr/lib/ruby/gems/1.8/gems/date_time-duration-0.0.1/lib,/usr/lib/ruby/gems/1.8/gems/date_time-smart-0.0.3/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-adjust-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ar-finders-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-cli-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ferret-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-list-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-nested_set-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-remixable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-searchable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-state_machine-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-tree-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-versioned-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-viewable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-more-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-observer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-querizer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-rest-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-shorthand-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.9.11/lib,/usr/lib/ruby/ge
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
13
normal zo
let s:l = 7 - ((6 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 028l
wincmd w
argglobal
edit views/main.rb
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
setlocal path=.,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.6/lib,/usr/lib/ruby/site_ruby/1.8,/usr/lib/ruby/site_ruby/1.8/i686-linux,/usr/lib/ruby/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i686-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i686-linux,,~/.gem/ruby/1.8/gems/Pratt-1.5.8/lib,~/.gem/ruby/1.8/gems/anvil-0.0.1/lib,~/.gem/ruby/1.8/gems/facets-2.7.0/lib,~/.gem/ruby/1.8/gems/shifty_week-0.1.1/lib,~/.gem/ruby/1.8/gems/treetop-1.4.2/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/Linguistics-1.0.5/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Text-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/acts_as_reportable-1.1.1/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.0.2/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/archive-tar-minitar-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/aws-s3-0.6.2/lib,/usr/lib/ruby/gems/1.8/gems/bluecloth-2.0.5/lib,/usr/lib/ruby/gems/1.8/gems/bones-2.5.1/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/case-0.5/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/chronic-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/color-1.4.0/lib,/usr/lib/ruby/gems/1.8/gems/colored-1.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/crack-0.1.4/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-dm-rest-adapter-0.9.12/lib,/usr/lib/ruby/gems/1.8/gems/date_time-duration-0.0.1/lib,/usr/lib/ruby/gems/1.8/gems/date_time-smart-0.0.3/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-adjust-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ar-finders-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-cli-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ferret-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-list-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-nested_set-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-remixable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-searchable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-state_machine-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-tree-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-versioned-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-viewable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-more-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-observer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-querizer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-rest-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-shorthand-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.9.11/lib,/usr/lib/ruby/ge
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
20
normal zo
24
normal zo
31
normal zo
38
normal zo
63
normal zo
let s:l = 9 - ((0 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 028l
wincmd w
argglobal
edit views/customer.rb
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
setlocal path=.,/usr/lib/ruby/gems/1.8/gems/gemcutter-0.1.6/lib,/usr/lib/ruby/site_ruby/1.8,/usr/lib/ruby/site_ruby/1.8/i686-linux,/usr/lib/ruby/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i686-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i686-linux,,~/.gem/ruby/1.8/gems/Pratt-1.5.8/lib,~/.gem/ruby/1.8/gems/anvil-0.0.1/lib,~/.gem/ruby/1.8/gems/facets-2.7.0/lib,~/.gem/ruby/1.8/gems/shifty_week-0.1.1/lib,~/.gem/ruby/1.8/gems/treetop-1.4.2/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/Linguistics-1.0.5/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.3/lib,/usr/lib/ruby/gems/1.8/gems/Text-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.1.1/lib,/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/acts_as_reportable-1.1.1/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.0.2/lib,/usr/lib/ruby/gems/1.8/gems/addressable-2.1.0/lib,/usr/lib/ruby/gems/1.8/gems/archive-tar-minitar-0.5.2/lib,/usr/lib/ruby/gems/1.8/gems/aws-s3-0.6.2/lib,/usr/lib/ruby/gems/1.8/gems/bluecloth-2.0.5/lib,/usr/lib/ruby/gems/1.8/gems/bones-2.5.1/lib,/usr/lib/ruby/gems/1.8/gems/builder-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/case-0.5/lib,/usr/lib/ruby/gems/1.8/gems/cgi_multipart_eof_fix-2.5.0/lib,/usr/lib/ruby/gems/1.8/gems/cheat-1.2.1/lib,/usr/lib/ruby/gems/1.8/gems/chronic-0.2.3/lib,/usr/lib/ruby/gems/1.8/gems/color-1.4.0/lib,/usr/lib/ruby/gems/1.8/gems/colored-1.1/lib,/usr/lib/ruby/gems/1.8/gems/columnize-0.3.1/lib,/usr/lib/ruby/gems/1.8/gems/crack-0.1.4/lib,/usr/lib/ruby/gems/1.8/gems/cucumber-0.3.104/lib,/usr/lib/ruby/gems/1.8/gems/daemons-1.0.10/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/data_objects-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/datamapper-dm-rest-adapter-0.9.12/lib,/usr/lib/ruby/gems/1.8/gems/date_time-duration-0.0.1/lib,/usr/lib/ruby/gems/1.8/gems/date_time-smart-0.0.3/lib,/usr/lib/ruby/gems/1.8/gems/diff-lcs-1.1.2/lib,/usr/lib/ruby/gems/1.8/gems/dm-adjust-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-aggregates-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ar-finders-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-cli-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-constraints-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-core-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-ferret-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-list-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-nested_set-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-remixable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-searchable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-state_machine-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-tree-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-versioned-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-is-viewable-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-migrations-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-more-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-observer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-querizer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-rest-adapter-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-serializer-0.9.11/lib,/usr/lib/ruby/gems/1.8/gems/dm-shorthand-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.10.0/lib,/usr/lib/ruby/gems/1.8/gems/dm-sweatshop-0.9.11/lib,/usr/lib/ruby/ge
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
10
normal zo
38
normal zo
46
normal zo
52
normal zo
58
normal zo
74
normal zo
81
normal zo
let s:l = 28 - ((6 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
28
normal! 022l
wincmd w
argglobal
edit lib/pratt.rb
inoremap <buffer> \. >
inoremap <buffer> \> >
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
28
normal zo
72
normal zo
72
normal zo
179
normal zo
233
normal zo
233
normal zo
245
normal zo
246
normal zo
245
normal zo
253
normal zo
257
normal zo
258
normal zo
257
normal zo
269
normal zo
300
normal zo
303
normal zo
304
normal zo
310
normal zo
304
normal zo
303
normal zo
318
normal zo
322
normal zo
327
normal zo
331
normal zo
327
normal zo
339
normal zo
341
normal zo
339
normal zo
350
normal zo
356
normal zo
360
normal zo
364
normal zo
370
normal zo
374
normal zo
380
normal zo
383
normal zo
388
normal zo
392
normal zo
396
normal zo
400
normal zo
403
normal zo
410
normal zo
414
normal zo
417
normal zo
421
normal zo
424
normal zo
427
normal zo
430
normal zo
433
normal zo
436
normal zo
440
normal zo
443
normal zo
446
normal zo
449
normal zo
452
normal zo
455
normal zo
458
normal zo
461
normal zo
466
normal zo
472
normal zo
476
normal zo
482
normal zo
487
normal zo
492
normal zo
495
normal zo
498
normal zo
501
normal zo
410
normal zo
400
normal zo
519
normal zo
523
normal zo
528
normal zo
530
normal zo
532
normal zo
538
normal zo
530
normal zo
546
normal zo
551
normal zo
552
normal zo
554
normal zo
552
normal zo
551
normal zo
562
normal zo
380
normal zo
269
normal zo
300
normal zo
303
normal zo
304
normal zo
310
normal zo
304
normal zo
303
normal zo
318
normal zo
322
normal zo
327
normal zo
331
normal zo
333
normal zo
331
normal zo
341
normal zo
343
normal zo
341
normal zo
351
normal zo
357
normal zo
361
normal zo
365
normal zo
371
normal zo
375
normal zo
381
normal zo
384
normal zo
389
normal zo
393
normal zo
397
normal zo
401
normal zo
404
normal zo
411
normal zo
415
normal zo
418
normal zo
422
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
441
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
467
normal zo
473
normal zo
477
normal zo
483
normal zo
488
normal zo
493
normal zo
496
normal zo
499
normal zo
502
normal zo
411
normal zo
401
normal zo
520
normal zo
524
normal zo
529
normal zo
531
normal zo
533
normal zo
539
normal zo
531
normal zo
547
normal zo
552
normal zo
553
normal zo
555
normal zo
553
normal zo
552
normal zo
563
normal zo
381
normal zo
327
normal zo
341
normal zo
343
normal zo
341
normal zo
351
normal zo
357
normal zo
361
normal zo
365
normal zo
371
normal zo
375
normal zo
381
normal zo
384
normal zo
389
normal zo
393
normal zo
397
normal zo
401
normal zo
404
normal zo
411
normal zo
415
normal zo
418
normal zo
422
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
441
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
467
normal zo
473
normal zo
477
normal zo
483
normal zo
488
normal zo
493
normal zo
496
normal zo
499
normal zo
502
normal zo
411
normal zo
401
normal zo
520
normal zo
524
normal zo
529
normal zo
531
normal zo
533
normal zo
539
normal zo
531
normal zo
547
normal zo
552
normal zo
553
normal zo
555
normal zo
553
normal zo
552
normal zo
563
normal zo
381
normal zo
28
normal zo
let s:l = 333 - ((17 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
333
normal! 012l
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 1resize ' . ((&columns * 93 + 140) / 280)
exe '2resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 2resize ' . ((&columns * 92 + 140) / 280)
exe '3resize ' . ((&lines * 37 + 38) / 77)
exe 'vert 3resize ' . ((&columns * 93 + 140) / 280)
exe '4resize ' . ((&lines * 37 + 38) / 77)
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
