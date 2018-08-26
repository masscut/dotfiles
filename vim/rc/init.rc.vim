"---------------------------------------------------------------------------
" Initialize:
"

let s:is_windows = has('win16') || has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
endif

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

if IsWindows()
  set runtimepath^=~/.vim
  set runtimepath+=~/.vim/after
  set shellslash
endif

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif
