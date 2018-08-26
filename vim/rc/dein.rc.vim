" ------------------------------------------------------------------------------
" dein:
"

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  call dein#begin(s:path, expand('<sfile>'))
  
  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy' : 1})

  call dein#disable('neobundle.vim')
  call dein#disable('neopairs.vim')

  call dein#end()
  call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif
