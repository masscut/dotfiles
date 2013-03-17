filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/ 
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplcache'`
"NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'sudo.vim'

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
set shiftwidth=4
set softtabstop=0
"-------------------------------------------------------------------------------
"" Color
"-------------------------------------------------------------------------------
if $TERM =~ "xterm-256color"
    set t_Co=256
    syntax on
    colorscheme wombat
endif

let g:hi_insert = 'highlight StatusLine guifg=white guibg=darkmagenta gui=none ctermfg=white ctermbg=magenta cterm=none'

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
"" StatusLine
"-------------------------------------------------------------------------------
set laststatus=2
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
set ruler
highlight StatusLine guifg=white guibg=darkblue gui=none ctermfg=white ctermbg=blue cterm=none
"-------------------------------------------------------------------------------
"" Search
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
"" wild
"-------------------------------------------------------------------------------
set wildmenu
set wildchar=<tab>
set wildmode=list:full
"-------------------------------------------------------------------------------
"" File
"-------------------------------------------------------------------------------
"------------------------------------
"" Python
"------------------------------------
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 shiftwidth=4 softtabstop=4
"------------------------------------
"" neocomplecache.vim
"------------------------------------
