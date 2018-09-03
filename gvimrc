let s:is_windows = has('win16') || has('win32') || has('win64')
" Option {{{1
" Window {{{2
set columns=240
set lines=80
set cmdheight=2
set transparency=10
set t_Co=256
colorscheme wombat256mod
" Font {{{2
if s:is_windows
	set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h12 
else
	set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h12 
endif
set antialias
" Mouse {{{2
"set mouse=a
"set nomousefocus
"set ttymouse=xterm2
"set guioptions+=a
" }}}1

" Color
"-------------------------------------------------------------------------------
"syntax on
