" ------------------------------------------------------------------------------
" plugin
"

if neobundle#tap('gundo.vim')
    let g:gundo_close_on_revert = 1 
    call neobundle#untap()
endif

if neobundle#tap('neocomplete.vim')
    let g:neocomplete#enable_at_startup = has('lua')
    let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neocomplete.rc.vim'

    call neobundle#untap()
endif 

if neobundle#tap('quickrun.vim')
    nmap <silent> <Leader>r <Plug>(quickrun)

    call neobundle#untap()
endif

if neobundle#tap('unite.vim')

    nnoremap [unite] <Nop>
    xnoremap [unite] <Nop>
    nmap ;u [unite]
    xmap ;u [unite]

    " Execute help
    nnoremap <silent> <C-h>  :<C-u>Unite -buffer-name=help help<CR>
    " Execute help by cursor keyword.
    nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

    call neobundle#untap()
endif

if neobundle#tap('vimshell.vim') "{{{
    " <C-Space>: switch to vimshell.
    nmap <C-@>  <Plug>(vimshell_switch)
    nnoremap !  q:VimShellExecute<Space>
    nnoremap [Space]i  q:VimShellInteractive<Space>
    nnoremap [Space]t  q:VimShellTerminal<Space>

    call neobundle#untap()
endif




