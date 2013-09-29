" Initialize {{{1


let s:is_windows = has('win16') || has('win32') || has('win64')

set nocompatible 
filetype off

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" Ignore default configuration while editing
" let plugin_cmdex_disable = 1
" }}}1

" Plugin {{{1
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/ 
endif

call neobundle#rc(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/vimshell'
NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'sjl/gundo.vim', {'autoload': {'commands': [{'name': 'GundoToggle'}]}}
NeoBundleLazy 'thinca/vim-quickrun', { 'autoload' : {
    \ 'mappings' : [
    \   ['nxo', '<Plug>(quickrun)']],
    \ }}
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {'autoload': {'commands': ['Gitv']}}
NeoBundleLazy 'sudo.vim', {'autoload': {'commands': ['SudoRead', 'SudoWrite']}}
" NeoBundle 'scrooloose/nerdtree'

call neobundle#config('vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ })

call neobundle#config('unite.vim',{
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'Unite',
      \                   'complete' : 'customlist,unite#complete_source'},
      \                 'UniteWithCursorWord', 'UniteWithInput']
      \ }})

"if has('lua') && ( (v:version == 703 && has('patch885')) || v:version >= 704 )
call neobundle#config('neocomplete.vim', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'insert' : 1,
    \   'commands' : 'NeoCompleteBufferMakeCache',
    \ }})
let g:neocomplete#enable_at_startup = 1
"endif

filetype plugin indent on

" Installation check.
NeoBundleCheck

" }}}1
" Option {{{1
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
" }}}1
" lightline {{{2
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'mode_map': { 'c': 'NORMAL' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'MyModified',
    \   'readonly': 'MyReadonly',
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode'
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
    \ }

function! MyModified()
    return &filetype =~ 'help\|git' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &filetype !~? 'help\|git' && &readonly ? '⭤' : ''
endfunction

function! MyFugitive()
    try
        if &filetype !~? 'git' && expand('%:t') !~? 'Gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? '⭠ '._ : ''
        endif
    catch
        endtry
        return ''
endfunction

function! MyFilename()
    let fname = expand('%:t')
    return fname =~ '__Gundo\|Gitv' ? '' :
        \ &filetype == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    let fname = expand('%:t')
        return fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ &filetype == 'gitv' ? 'Gitv' :
            \ &filetype == 'git' ? 'Git' :
            \ &filetype == 'vimshell' ? 'VimShell' :
            \ &filetype == 'dictionary' ? 'Dictionary' :
            \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

" map {{{1
let mapleader = ","
noremap \  ,

nmap <silent> <Leader>r <Plug>(quickrun)
inoremap jj <Esc>

nmap <ESC><ESC> :nohlsearch<CR><ESC>

" always escape / and ? in search character.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

nnoremap <Down> gj
nnoremap <Up>   gk

nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" unite {{{2
let s:hooks = neobundle#get_hooks("unite.vim")
function! s:hooks.on_source(bundle)
endfunction
unlet s:hooks

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap ;u [unite]
xmap ;u [unite]

" vimshell {{{2
let s:hooks = neobundle#get('vimshell')
function! s:hooks.hooks.on_source(bundle)
    let g:vimshell_interactive_update_time = 150
    let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
    let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
endfunction
unlet s:hooks

" Gundo {{{2
let s:hooks = neobundle#get_hooks("gundo.vim")
function! s:hooks.on_source(bundle)
    let g:gundo_close_on_revert = 1 
endfunction
unlet s:hooks
nnoremap U :<C-u>GundoToggle<CR>
" neocomplete {{{2
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
    " Use smartcase
    let g:neocomplete#enable_smart_case = 1
    " Use fuzzy completion.
    let g:neocomplete#enable_fuzzy_completion = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " Set auto completion length.
    let g:neocomplete#auto_completion_start_length = 2 
    " Set manual completion length.
    let g:neocomplete#manual_completion_start_length = 0
    " Set minimum keyword length.
    let g:neocomplete#min_keyword_length = 3   

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ }

    " Insert delimiter automatically; /(filename) or #(Vim script)
    let g:neocomplete#enable_auto_delimiter = 1

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    if !exists('g:neocomplete#sources#omni#functions')
        let g:neocomplete#sources#omni#functions = {}
    endif
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
endfunction
unlet s:hooks

" quickrun {{{2
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
        \ "_": {
            "runner": "remote/vimproc"},
            "outputter/buffer/split" : ":botright 8sp",
        \ }
endfunction
unlet s:hooks

" }}}1

augroup MyAutoCmd
    " Close windows
    autocmd FileType help,quickrun nnoremap <buffer><silent> q :<C-u>call <SID>smart_close()<CR>

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    if has('python3')
        autocmd FileType python setlocal omnifunc=python3complete#Complete
    else
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    endif
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

function! s:smart_close()
    if winnr('$') != 1
        close
    endif
endfunction

" vim:set foldmethod=marker:
" vim:set foldlevel=1:
"
