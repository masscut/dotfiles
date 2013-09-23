" Initialize {{{1
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
" neobundle {{{2
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/ 
endif

call neobundle#rc(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

 " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" lightline {{{2
NeoBundle 'itchyny/lightline.vim'
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

" vimshell {{{2
NeoBundle 'Shougo/vimshell'
let s:bundle = neobundle#get('vimshell')
function! s:bundle.hooks.on_source(bundle)
    let g:vimshell_interactive_update_time = 150
    let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
    let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
endfunction
unlet s:bundle

" Gundo {{{ 2
NeoBundleLazy 'sjl/gundo.vim', {'autoload': {'commands': [{'name': 'GundoToggle'}]}}
let s:bundle = neobundle#get_hooks("gundo.vim")
function! s:bundle.on_source(bundle)
    let g:gundo_close_on_revert = 1 
endfunction
unlet s:bundle

nnoremap <F5> :GundoToggle<CR>

" neocomplete {{{2
if has("lua")
    NeoBundleLazy 'Shougo/neocomplete', { 'autoload' : { 'insert' : 1 } }
    let g:neocomplete#enable_at_startup = 1
endif

let s:bundle = neobundle#get_hooks("neocomplete.vim")
function! s:bundle.on_source(bundle)
    " Use smartcase
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
    endif
    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endfunction
unlet s:bundle

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
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

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" etc {{{2
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'gregsexton/gitv'

" NeoBundle 'scrooloose/nerdtree'

NeoBundleLazy 'sudo.vim', {'autoload': {'commands': ['SudoRead', 'SudoWrite']}}

filetype plugin indent on

" Installation check.
NeoBundleCheck

" }}}1
" Option {{{1
" see http://vimwiki.net/?OptionList
set ambiwidth=double
set modeline
" File {{{2
set autoread
set nobackup
set noswapfile
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
" Edit {{{2
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=0
set showmatch
set matchtime=3
set tabstop=4
set textwidth=0

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
nmap <ESC><ESC> :nohlsearch<CR><ESC>
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

" map
" always escape / and ? in search character.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" vim:set foldmethod=marker:
" vim:set foldlevel=1:
"
