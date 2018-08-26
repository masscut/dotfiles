" ------------------------------------------------------------------------------
" vimrc:
"

if &compatible
  set nocompatible
endif

filetype off

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting')
  source ~/.vim/rc/init.rc.vim
endif

source ~/.vim/rc/dein.rc.vim

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax enable
  filetype plugin indent on
endif

source ~/.vim/rc/edit.rc.vim
source ~/.vim/rc/filetype.rc.vim
source ~/.vim/rc/mappings.rc.vim

if IsWindows()
  source ~/.vim/rc/windows.rc.vim
endif

" vim:set foldmethod=marker:
" vim:set foldlevel=1:
"
