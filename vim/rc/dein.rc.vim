" ------------------------------------------------------------------------------
" dein:
"

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

let s:dein_toml = '~/.vim/rc/dein.toml'
let s:dein_lazy_toml = '~/.vim/rc/deinlazy.toml'

call dein#begin(s:path, [expand('<sfile>'), s:dein_toml, s:dein_lazy_toml])

call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy' : 1})

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif
