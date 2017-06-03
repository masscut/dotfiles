" ------------------------------------------------------------------------------
" file type
"
augroup MyAutoCmd
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType python setlocal completeopt-=preview
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

augroup END
