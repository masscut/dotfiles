" ------------------------------------------------------------------------------
" key mapping
"

"let mapleader = ","
"noremap \  ,

"nmap <silent> <Leader>r <Plug>(quickrun)
"inoremap jj <Esc>

nmap <ESC><ESC> :nohlsearch<CR><ESC>

" always escape / and ? in search character.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

nnoremap <Down> gj
nnoremap <Up>   gk

" <C-n>: next history.
cnoremap <C-n> <Down>
" <C-p>: previous history.
cnoremap <C-p> <Up>

" tab jump
nnoremap [Tag] <Nop>
nmap t [Tag]
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tab change
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>

"Gundo
nnoremap U :<C-u>GundoToggle<CR>

"function! s:smart_close()
"    if winnr('$') != 1
"        close
"    endif
"endfunction
