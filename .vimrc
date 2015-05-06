" ------------------------------------------------------------------------------
" vimrc
"

let s:is_windows = has('win16') || has('win32') || has('win64')

if s:is_windows
    let g:neobundle_default_git_protocol='https'
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

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/ 
endif

call neobundle#begin(expand('$HOME/.vim/bundle/'))

if neobundle#has_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    }
        \ }

    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'itchyny/lightline.vim'

    call neobundle#load_toml('$HOME/.vim/neobundle.toml', {'lazy' : 1})

    NeoBundleLoadCache
else
    NeoBundleSaveCache
endif

source ~/.vim/rc/plugins.rc.vim

call neobundle#end()

filetype plugin indent on

" Installation check.
NeoBundleCheck

source ~/.vim/rc/edit.rc.vim

source ~/.vim/rc/plugins/lightline.rc.vim

source ~/.vim/rc/mappings.rc.vim

" vim:set foldmethod=marker:
" vim:set foldlevel=1:
"
