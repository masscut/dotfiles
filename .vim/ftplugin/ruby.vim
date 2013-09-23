let s:save_cpo = &cpo
set cpo&vim

set shiftwidth=2
set tabstop=2
set softtabstop=0

let &cpo = s:save_cpo
unlet s:save_cpo
