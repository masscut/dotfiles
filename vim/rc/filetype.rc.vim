" ------------------------------------------------------------------------------
" file type
"
augroup MyAutoCmd
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python
        \ if has('python') |
        \   setlocal omnifunc=pythoncomplete#Complete
        \ endif |
        \ if has('python3') |
        \   setlocal omnifunc=python3complete#Complete
        \ endif
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  autocmd FileType python setlocal foldmethod=indent

augroup END
