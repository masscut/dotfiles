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
" StatusLine
"-------------------------------------------------------------------------------
set laststatus=2
set ruler

augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 ctermfg=red
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 ctermfg=white
augroup END
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
