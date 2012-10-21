"-------------------------------------------------------------------------------
"" Window
"-------------------------------------------------------------------------------
set columns=100
set lines=60
"-------------------------------------------------------------------------------
"" Color
"-------------------------------------------------------------------------------
if $TERM =~ "xterm-256color"
    set t_Co=256
    syntax on
    colorscheme wombat
endif

let g:hi_insert = 'highlight StatusLine guifg=white guibg=darkmagenta gui=none ctermfg=white ctermbg=magenta cterm=none'

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction
"-------------------------------------------------------------------------------
"" StatusLine
"-------------------------------------------------------------------------------
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
highlight StatusLine guifg=white guibg=darkblue gui=none ctermfg=white ctermbg=blue cterm=none
"-------------------------------------------------------------------------------
"" Mouse
"-------------------------------------------------------------------------------
set mouse=a
set ttymouse=xterm2
set guioptions+=a
"-------------------------------------------------------------------------------
"" Font
"-------------------------------------------------------------------------------
set guifont=Consolas:h12
set guifontwide=Osaka:h12
set antialias
