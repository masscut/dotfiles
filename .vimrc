" ------------------------------------------------------------------------------
" vimrc
"

let s:is_windows = has('win16') || has('win32') || has('win64')

if s:is_windows
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
  set encoding=utf-8
endif

set nocompatible 
filetype off

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

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
  execute ' set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  call dein#begin(s:path, [expand('<sfile>')] + split(glob('~/.vim/rc/*.toml'), '\n'))

  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy' : 1})

  call dein#disable('neobundle.vim')
  call dein#disable('neopairs.vim')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax enable
  filetype plugin indent on
endif

source ~/.vim/rc/edit.rc.vim
source ~/.vim/rc/filetype.rc.vim
source ~/.vim/rc/mappings.rc.vim

" vim:set foldmethod=marker:
" vim:set foldlevel=1:
"
