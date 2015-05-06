" ------------------------------------------------------------------------------
" lightline
"

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'mode_map': { 'c': 'NORMAL' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'MyModified',
    \   'readonly': 'MyReadonly',
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode'
    \ },
    \ 'tab_component_function': {
    \   'filename': 'MyTabFilename',
    \   'readonly': 'MyTabReadonly',
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
    \ }

function! MyModified()
    return &filetype =~ 'help\|git' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &filetype !~? 'help\|git' && &readonly ? '⭤' : ''
endfunction

function! MyFugitive()
    try
        if &filetype !~? 'git' && expand('%:t') !~? 'Gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? '⭠ '._ : ''
        endif
    catch
        endtry
        return ''
endfunction

function! MyFilename()
    let fname = expand('%:t')
    return fname =~ '__Gundo\|Gitv' ? '' :
        \ &filetype == 'unite' ? unite#get_status_string() :
        \ &filetype == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return &filetype !~? 'vimshell' && winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    let fname = expand('%:t')
        return fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ &filetype == 'gitv' ? 'Gitv' :
            \ &filetype == 'git' ? 'Git' :
            \ &filetype == 'gitcommit' ? 'fugitive' :
            \ &filetype == 'unite' ? 'Unite' :
            \ &filetype == 'vimshell' ? 'VimShell' :
            \ &filetype == 'dictionary' ? 'Dictionary' :
            \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyTabReadonly(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&readonly') ? '⭤' : ''
endfunction

function! MyTabFilename(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let fname = expand("#".buflist[winnr - 1].":t")
    let ft = gettabwinvar(a:n, winnr, '&filetype')
    return fname == '__Tagbar__' ? 'Tagbar' :
          \ fname =~ '__Gundo' ? 'Gundo' :
          \ &filetype == 'unite' ? 'Unite' :
          \ &filetype == 'vimshell' ? 'VimShell' :
          \ &filetype == 'dictionary' ? 'Dictionary' :
        \ strlen(fname) ? fname : '[No Name]'
endfunction


