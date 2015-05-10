" ------------------------------------------------------------------------------
" edit
"

" File {{{2
set modeline
set nobackup
set autoread
set noswapfile
set nowritebackup
set hidden
" Display {{{2
if $TERM =~ "xterm-256color"
    set t_Co=256
    colorscheme wombat256mod
endif
"set foldcolumn=5
set nolist
set number
set ruler
set scrolloff=5
set showcmd
set showmode
set title
set wrap
set laststatus=2
set cmdheight=2
set formatoptions+=mM
set showtabline=2
set ambiwidth=double
" Edit {{{2
set autoindent
set shiftround
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=0
set showmatch
set matchtime=3
set tabstop=4
set textwidth=0
set matchpairs& matchpairs+=<:>
set clipboard& clipboard+=unnamed
set undodir=~/.vim/undo
set nrformats=hex
" Search {{{2
if &t_Co >2 || has("gui_running")
    syntax on
    set hlsearch
endif
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
" Mouse {{{2
if has('mouse')
    set mouse=a
    set nomousefocus
    set ttymouse=xterm2
    set guioptions+=a
endif
" wild {{{2
set wildmenu
set wildmode=list:full

set history 200
