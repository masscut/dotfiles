filetype off

set rtp+=~/dotfiles/.vim/vundle.git/
call vundle#rc()

Bundle 'Shougo/neocomplcache'
Bundle 'vim-jp/vimdoc-ja'
Bundle 'gmarik/vundle'

filetype plugin indent on
"-------------------------------------------------------------------------------
"" Basics
"-------------------------------------------------------------------------------
" see http://vimwiki.net/?OptionList
set nocompatible
set scrolloff=5
set textwidth=0
set nobackup
set autoread
set noswapfile
set hidden
set backspace=indent,eol,start
set showcmd
set showmode
set number
set showmatch
set expandtab
set tabstop=4 
syntax on
"-------------------------------------------------------------------------------
"" Color
"-------------------------------------------------------------------------------
if &term =~ "xterm-256color"
	"256色表示
	set t_Co=256
	"シンタックスハイライトを有効にする
	syntax on
	"カラースキーマ
	colorscheme railscasts 
endif

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
"-------------------------------------------------------------------------------
" StatusLine
"-------------------------------------------------------------------------------
set laststatus=2
set ruler
"-------------------------------------------------------------------------------
" Search
"-------------------------------------------------------------------------------
set wrapscan
set ignorecase
set smartcase
set autoindent
set hlsearch
nmap <ESC><ESC> :nohlsearch<CR><ESC>
"-------------------------------------------------------------------------------
"" Mouse
"-------------------------------------------------------------------------------
"set mouse=a
"set ttymouse=xterm2
"-------------------------------------------------------------------------------
" wild
"-------------------------------------------------------------------------------
set wildmenu
set wildchar=<tab>
set wildmode=list:full
"------------------------------------
"" neocomplecache.vim
"------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_minsyntaxlength = 3

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
