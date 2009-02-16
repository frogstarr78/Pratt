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
" vim: set ft=vim :
