"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Amix - http://amix.dk/
"
" Maintainer: redguardtoo <chb_sh@hotmail.com>, Amir Salihefendic <amix3k at gmail.com>
" Version: 2.1
" Last Change: 21/03/08 23:00:01 
" fix some performance issue and syntax bug
" Last Change: 12/08/06 13:39:28
" Fixed (win32 compatible) by: redguardtoo <chb_sh at gmail.com>
" This vimrc file is tested on platforms like win32,linux, cygwin,mingw
" and vim7.0, vim6.4, vim6.1, vim5.8.9 by redguardtoo
"
"
" Tip:
" If you find anything that you can't understand than do this:
" help keyword OR helpgrep keyword
" Example:
" Go into command-line mode and type helpgrep nocompatible, ie.
" :helpgrep nocompatible
" then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off nice effect on status bar title
let performance_mode=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set terminal color to 256 get same colorscheme as gui
set t_Co=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..

set nocompatible

function! MySys()
	if has("win32")
		return "win32"
	elseif has("unix")
		return "unix"
	else
		return "mac"
	endif
endfunction
"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
	set shell=bash
else
	"I have to run win32 python without cygwin
	"set shell=E:cygwininsh
endif

"Sets how many lines of history VIM har to remember
set history=5000

"set runtimepath=~/Downloads/vim,$VIMRUNTIME
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
"Enable filetype plugin
filetype on
if has("eval") && v:version>=600
	filetype plugin on
	filetype indent on
endif

set showcmd 
"set whichwrap=b,s,<,>,[,]
"set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]

"Set to auto read when a file is changed from the outside
if exists("&autoread")
	set autoread
endif

"Have the mouse enabled all the time:
if exists("&mouse")
    set mouse=r
    set selection=exclusive
    set selectmode=mouse,key 
endif

"Set mapleader
let mapleader = ";"
let g:mapleader = ";"

"Fast saving
nmap <leader>x :xa!<cr>
nmap <leader>w :w!<cr>

"cmap w!!... causes delays when typing 'w'in command mode, at least in terminal versions. There is a better scriptbit:
cmap w!! w !sudo tee % >/dev/null
"cnoreabbrev <expr> w!! ((getcmdtype() is# ':' && getcmdline() is# 'w!!')?('!sudo tee % >/dev/null'):('w!!'))

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0 

" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
	if v:version<600
		if filereadable(expand("$VIM/syntax/syntax.vim"))
			syntax on
		endif
	else
		syntax on
	endif
else
	syntax on
endif

"internationalization
"I only work in Win2k Chinese version
if has("multi_byte")
	"set bomb 
  set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1 
  " CJK environment detection and corresponding setting 
  if v:lang =~ "^zh_CN" 
    " Use cp936 to support GBK, euc-cn == gb2312 
    set encoding=cp936 
    set termencoding=cp936 
    set fileencoding=cp936 
  elseif v:lang =~ "^zh_TW" 
    " cp950, big5 or euc-tw 
    " Are they equal to each other? 
    set encoding=big5 
    set termencoding=big5 
    set fileencoding=big5 
  elseif v:lang =~ "^ko" 
    " Copied from someone's dotfile, untested 
    set encoding=euc-kr 
    set termencoding=euc-kr 
    set fileencoding=euc-kr 
  elseif v:lang =~ "^ja_JP" 
    " Copied from someone's dotfile, untested 
    set encoding=euc-jp 
    set termencoding=euc-jp 
    set fileencoding=euc-jp 
  endif 
  " Detect UTF-8 locale, and replace CJK setting if needed 
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$" 
    set encoding=utf-8 
    set termencoding=utf-8 
    set fileencoding=utf-8 
  endif
endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
	set ambiwidth=double
endif

if has("gui_running")
	set guioptions-=m
	set guioptions-=T
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R

	if MySys()=="win32"
		"start gvim maximized
		if has("autocmd")
			au GUIEnter * simalt ~x
		endif
  else
    au GUIEnter * winsize 240 66
	endif

	"let psc_style='cool'
	if v:version > 601 
		"colorscheme ps_color
		"colorscheme default
		"colorscheme navajo-night
		colorscheme molokai
	endif
else
	if v:version > 601 
		"set background=dark
		"colorscheme default
    "colorscheme desert
    colorscheme elflord
	endif
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"map <leader>1 :set syntax=cheetah<cr>
map <leader>1 :set syntax=c<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

"Highlight current
hi CursorLine cterm=none ctermbg=black
hi TabLine cterm=none ctermbg=darkgrey ctermfg=red
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
if exists("&cursorline")
    set cursorline
    "autocmd WinEnter * setlocal cursorline
    "autocmd WinLeave * setlocal nocursorline
    nnoremap <leader>c :set cursorline! cursorcolumn!<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,mac,dos

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=0

"Turn on WiLd menu
set wildmenu

set wildignore=*.swp,*.bak,*.pyc,*.class

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=1

"Show line number
set number

"Do not redraw, when running macros.. lazyredraw
set lazyredraw

"Change buffer - without saving
set hidden

"Set backspace
set backspace=indent,eol,start

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Set magic on
set magic

"No sound on errors.
"set noerrorbell
set novisualbell
set t_vb=

"show matching bracet
set showmatch
set matchtime=5

"How many tenths of a second to blink
set mat=8

"Ignore case when searching
set ignorecase
set incsearch

"Highlight search thing
set hlsearch
set smartcase
nmap <silent> <leader>l :nohlsearch<CR>

"Remove useless splash screen
set shortmess=a

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
if performance_mode
else
	set laststatus=2
	set statusline=
	set statusline+=%2*%-3.3n%0*\ " buffer number
	set statusline+=lines:%L\ \ \ %F\ " file name
	set statusline+=%h%1*%m%r%w%0* " flag
	set statusline+=[
	if v:version >= 600
		set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
		set statusline+=%{&encoding}, " encoding
	endif
	set statusline+=%{&fileformat}] " file format

	set statusline+=%= " right align
    set statusline+=\ [ASCII=%b,
    set statusline+=\ HEX=0x%02.2B]\ 

	if filereadable(expand("$VIM/plugin/vimbuddy.vim"))
		set statusline+=\ %{VimBuddy()} " vim buddy
	endif
	"set statusline+=%2*0x%-8B\ " current char
	set statusline+=%12.(%l,%c%V%)\ %<%P " offset

	" special statusbar for special window
	if has("autocmd")
		au FileType qf
					\ if &buftype == "quickfix" |
					\ setlocal statusline=%2*%-3.3n%0* |
					\ setlocal statusline+=\ \[Compiler\ Messages\] |
					\ setlocal statusline+=%=%2*\ %<%P |
					\ endif

		fun! FixMiniBufExplorerTitle()
			if "-MiniBufExplorer-" == bufname("%")
				setlocal statusline=%2*%-3.3n%0*
				setlocal statusline+=\[Buffers\]
				setlocal statusline+=%=%2*\ %<%P
			endif
		endfun

		if v:version>=600
      autocmd BufWinLeave *.* mkview
      autocmd BufWinEnter *.* silent loadview

			au BufWinEnter *.*
						\ let oldwinnr=winnr() |
						\ windo call FixMiniBufExplorerTitle() |
						\ exec oldwinnr . " wincmd w"
		endif
	endif

	" Nice window title
	if has('title') && (has('gui_running') || &title)
		set titlestring=
		set titlestring+=%f\ " file name
		set titlestring+=%h%m%r%w " flag
		set titlestring+=\ -\ %{v:progname} " program name
	endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
"map <space> /

"Smart way to move btw. window
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <C-x> <C-W>x
nmap <C-p> <C-W>p

imap <c-b> <left>
imap <c-j> <down>
imap <c-f> <right>

if v:version>=700
	set switchbuf=usetab
endif

if exists("&showtabline")
	set showtabline=2
endif

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

"remap escape key when insert mode
inoremap jj <esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $( <esc>`>a)<esc>`<i(<esc>
vnoremap $[ <esc>`>a]<esc>`<i[<esc>
vnoremap ${ <esc>`>a}<esc>`<i{<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $< <esc>`>a><esc>`<i<<esc>

"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"My information
ia xdate <c-r>=strftime("%y-%m-%d %H:%M:%S")<cr>
iab xname Rick Lee

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^
  
"Tabularize shortcut
if exists(':Tabularize') 
  nmap <leader>a= :Tabularize /=<cr>
  vmap <leader>a= :Tabularize /=<cr>
  nmap <leader>a: :Tabularize /:<cr>
  vmap <leader>a: :Tabularize /:<cr>
  nmap <leader>a. :Tabularize /=><cr>
  vmap <leader>a. :Tabularize /=><cr>
  nmap <leader>al :Tabularize /\|<cr>
  vmap <leader>al :Tabularize /\|<cr>

  inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

  function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
endif

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
	let cwd = getcwd()
	return "e " . cwd
endfunc

func! DeleteTillSlash()
	let g:cmd = getcmdline()
	if MySys() == "unix" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
	else
		let g:cmd_edited = substitute(g:cmd, "(.*[\]).*", "", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "unix" || MySys() == "mac"
			let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
		else
			let g:cmd_edited = substitute(g:cmd, "(.*[\]).*[\]", "", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>

"Bash like
cno <C-A> <Home>
cno <C-E> <End>
cno <C-K> <C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo
"set viminfo+=!

" Buffer - reverse everything ... :)
" map <F9> ggVGg?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
  set fen
endif
if exists("&foldlevel")
  set fdl=0
endif

"" set foldmethod=indent   "fold based on indent
"" set foldnestmax=10      "deepest fold is 10 level
"" set foldlevel=0         "this is just what i use


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set lbr
"set tw=500

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set autoindent

"Smart indet
"set si
set smartindent

"C-style indenting
if has("cindent")
	set cindent
endif

"Wrap line
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Yank Ring
""""""""""""""""""""""""""""""
"map <leader>y :YRShow<cr>

""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=35

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0


""""""""""""""""""""""""""""""
" => Minibuffer
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

"WindowZ
"map <c-w><c-t> :WMToggle<cr>
let g:bufExplorerSortBy = "name"

""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'

"NERDTree
let NERDTreeShowBookmarks=1
map <leader>n <plug>NERDTreeTabsToggle<cr>

if has("autocmd") && v:version>600
  autocmd vimenter * NERDTree
  autocmd vimenter * wincmd p
  autocmd VimEnter * set buftype=""
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  autocmd BufNewFile,BufRead *.todo so ~/.vim/syntax/amido.vim
	autocmd BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
	autocmd BufRead,BufNew .vimrc map <buffer> <leader><space> :w!<cr>:source %<cr>
  autocmd BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

	autocmd BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
	"Binding
	autocmd BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

	"Auto complete some things ;)
	autocmd BufRead *.tex ino <buffer> $i indent
	autocmd BufRead *.tex ino <buffer> $* cdot
	autocmd BufRead *.tex ino <buffer> $i item
	autocmd BufRead *.tex ino <buffer> $m [<cr>]<esc>O
endif

""""""""""""""""""""""""""""""
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = "/usr/bin/ctags-exuberant"
"let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
"let Tlist_Show_Menu = 1
map <leader>t :Tlist<cr>

"Tab configuration
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
nmap <tab> :tabnext<cr>
vmap <tab> :tabnext<cr>
nmap <S-tab> :tabprevious<cr>
vmap <S-tab> :tabprevious<cr>

" window
nmap <leader>swh  :topleft  vnew<cr>
nmap <leader>swl  :botright vnew<cr>
nmap <leader>swk  :topleft  new<cr>
nmap <leader>swj  :botright new<cr>

" buffer
nmap <leader>sh   :leftabove  vnew<cr>
nmap <leader>sl   :rightbelow vnew<cr>
nmap <leader>sk   :leftabove  new<cr>
nmap <leader>sj   :rightbelow new<cr>

"Remove indenting on empty line
map <F2> :%s/s*$//g<cr>:noh<cr>''
map <F3> :Tlist<cr>
map <F4> :NERDTreeToggle<cr>
map <F8> <esc>:EnableFastPHPFolds<cr>
map <C-F8> <esc>:DisablePHPFolds<cr>
map <F9> :e $HOME/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1

"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1


""""""""""""""""""""""""""""""
" => Ruby & PHP section
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
""Run the current buffer in python - ie. on leader+space
"au BufNewFile,BufRead *.py so ~/$VIM/syntax/python.vim
"au BufNewFile,BufRead *.py map <buffer> <leader><space> :w!<cr>:!python %<cr>
"au BufNewFile,BufRead *.py so ~/$VIM/plugin/python_fold.vim

""Set some bindings up for 'compile' of python
"au BufNewFile,BufRead *.py set makeprg=python -c "import py_compile,sys; sys.stderr=sys.stdout; py_compile.compile(r'%')"
"au BufNewFile,BufRead *.py set efm=%C %.%#,%A File "%f", line %l%.%#,%Z%[%^ ]%@=%m
"au BufNewFile,BufRead *.py nmap <buffer> <F8> :w!<cr>:make<cr>

""Python iMap
"au BufNewFile,BufRead *.py set cindent
"au BufNewFile,BufRead *.py ino <buffer> $r return
"au BufNewFile,BufRead *.py ino <buffer> $s self
"au BufNewFile,BufRead *.py ino <buffer> $c ##<cr>#<space><cr>#<esc>kla
"au BufNewFile,BufRead *.py ino <buffer> $i import
"au BufNewFile,BufRead *.py ino <buffer> $p print
"au BufNewFile,BufRead *.py ino <buffer> $d """<cr>"""<esc>O

""Run in the Python interpreter
"function! Python_Eval_VSplit() range
" let src = tempname()
" let dst = tempname()
" execute ": " . a:firstline . "," . a:lastline . "w " . src
" execute ":!python " . src . " > " . dst
" execute ":pedit! " . dst
"endfunction
"au BufNewFile,BufRead *.py vmap <F7> :call Python_Eval_VSplit()<cr>


""""""""""""""""""""""""""""""
" => Cheetah section
"""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" => Java section
"""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.js so ~/$VIM/syntax/javascript.vim
"function! JavaScriptFold()
" set foldmethod=marker
" set foldmarker={,}
" set foldtext=getline(v:foldstart)
"endfunction
"au BufNewFile,BufRead *.js call JavaScriptFold()
"au BufNewFile,BufRead *.js imap <c-t> console.log();<esc>hi
"au BufNewFile,BufRead *.js imap <c-a> alert();<esc>hi
"au BufNewFile,BufRead *.js set nocindent
"au BufNewFile,BufRead *.js ino <buffer> $r return

"au BufNewFile,BufRead *.js ino <buffer> $d //<cr>//<cr>//<esc>ka<space>
"au BufNewFile,BufRead *.js ino <buffer> $c /**<cr><space><cr>**/<esc>ka


if has("eval") && has("autocmd")
	"vim 5.8.9 on mingw donot know what is <SID>, so I avoid to use function
	"c/cpp
	fun! Abbrev_cpp()
		ia <buffer> cci const_iterator
		ia <buffer> ccl cla
		ia <buffer> cco const
		ia <buffer> cdb bug
		ia <buffer> cde throw
		ia <buffer> cdf /** file<cr><cr>/<Up>
		ia <buffer> cdg ingroup
		ia <buffer> cdn /** Namespace <namespace<cr><cr>/<Up>
		ia <buffer> cdp param
		ia <buffer> cdt test
		ia <buffer> cdx /**<cr><cr>/<Up>
		ia <buffer> cit iterator
		ia <buffer> cns Namespace ianamespace
		ia <buffer> cpr protected
		ia <buffer> cpu public
		ia <buffer> cpv private
		ia <buffer> csl std::list
		ia <buffer> csm std::map
		ia <buffer> css std::string
		ia <buffer> csv std::vector
		ia <buffer> cty typedef
		ia <buffer> cun using Namespace ianamespace
		ia <buffer> cvi virtual
		ia <buffer> #i #include
		ia <buffer> #d #define
	endfunction

	fun! Abbrev_java()
		ia <buffer> #i import
		ia <buffer> #p System.out.println
		ia <buffer> #m public static void main(String[] args)
	endfunction

	fun! Abbrev_python()
		ia <buffer> #i import
		ia <buffer> #p print
		ia <buffer> #m if __name__=="__main__":
	endfunction

	fun! Abbrev_aspvbs()
		ia <buffer> #r Response.Write
		ia <buffer> #q Request.QueryString
		ia <buffer> #f Request.Form
	endfunction

	fun! Abbrev_js()
		ia <buffer> #a if(!0){throw Error(callStackInfo());}
	endfunction

	augroup abbreviation
		au!
		au FileType javascript :call Abbrev_js()
		au FileType cpp,c :call Abbrev_cpp()
		au FileType java :call Abbrev_java()
		au FileType python :call Abbrev_python()
		au FileType aspvbs :call Abbrev_aspvbs()
	augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <leader>m :%s/\r//g<cr>

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F7>

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"clipboard with xclip
if MySys() == "unix" 
	vmap <F6> :!xclip -sel c<cr>
	map <F7> :-1r!xclip -o -seln c<cr>'z
endif

"vimshell
nmap <leader><C-d> :vnew \| VimShell<cr>
inoremap <C-d> exit

"""""""""""""""""""""""""""""""""""""""""""""NEOCOMPLCACHE"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <plug>(neocomplcache_snippets_expand)
smap <C-k>     <plug>(neocomplcache_snippets_expand)
inoremap <expr><c-g>     neocomplcache#undo_completion()
inoremap <expr><c-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <cr>: close popup and save indent.
inoremap <expr><cr>  neocomplcache#smart_close_popup() . "\<cr>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTag
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTag

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
" let g:acp_enableAtStartup = 0

"""""""""""""""""""""""""""""""""""""""""""""NEOCOMPLCACHE"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""" Erlang """""""""""""""""""""
let g:erlangManPath="/usr/lib/erlang/man"


" TVO defaults:
let otl_install_menu=1
let no_otl_maps=0
let no_otl_insert_maps=0

" overrides:
let otl_bold_headers=1
let otl_use_thlnk=0

"let g:loaded_unite=1
"let g:loaded_neocomplcache=1
"let g:loaded_vimshell=1

"evervim developer token
let g:evervim_devtoken='S=s1:U=abe9:E=142f096c047:C=13b98e59447:P=1cd:A=en-devtoken:H=a4bfe04e83ebb4feead845b30659c8f4'

"Gmail settings
let g:gmail_imap = 'imap.gmail.com:993'
let g:gmail_smtp = 'smtp.gmail.com:465'
let g:gmail_user_name = 'rick1125@gmail.com'
let g:gmail_default_encoding = "utf-8"

" w3m settings
let g:w3m#external_browser = 'firefox'
let g:w3m#homepage = "http://www.google.com/"
let g:w3m#search_engine = 
    \ 'http://www.google.com/search?ei=' . &encoding . '&aq=&oq=&p='

function! VimwikiLinkHandler(link)
    call w3m#Open(g:w3m#OPEN_TAB, a:link)
    return 1
endfunction
