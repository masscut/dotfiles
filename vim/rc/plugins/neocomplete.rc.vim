" ------------------------------------------------------------------------------
" neocomplete
"

let g:neocomplete#disable_auto_complete = 0

" Use smartcase
let g:neocomplete#enable_smart_case = 1

" Use fuzzy completion.
let g:neocomplete#enable_fuzzy_completion = 1

" Set auto completion length.
let g:neocomplete#auto_completion_start_length = 2 
" Set manual completion length.
let g:neocomplete#manual_completion_start_length = 0
" Set minimum keyword length.
let g:neocomplete#min_keyword_length = 3   

" Insert delimiter automatically; /(filename) or #(Vim script)
let g:neocomplete#enable_auto_delimiter = 1

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.python = '[^. *\t]\.\w*\|\h\w*'

" Define keyword pattern.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\k*'

let g:neocomplete#enable_auto_close_preview = 1

" mappings.
" <C-f>, <C-b>: page move.
inoremap <expr><C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b>  pumvisible() ? "\<PageUp>"   : "\<Left>"
" <C-y>: paste.
inoremap <expr><C-y>  pumvisible() ? neocomplete#close_popup() :  "\<C-r>\""
" <C-e>: close popup.
inoremap <expr><C-e>  pumvisible() ? neocomplete#cancel_popup() : "\<End>"
" <C-k>: unite completion.
imap <C-k>  <Plug>(neocomplete_start_unite_complete)
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" <C-n>: neocomplete.
inoremap <expr> <C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"
" <C-p>: keyword completion.
inoremap <expr> <C-p>  pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"

inoremap <silent><expr> <C-x><C-f>
      \ neocomplete#start_manual_complete('file')

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
