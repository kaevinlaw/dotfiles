" fzf and ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.cache,.ccache,.clangd,.conan,.git}/*"'
let g:fzf_layout = {'window' : {'width': 0.95, 'height' : 0.9}}
" let g:fzf_layout = {'down' : '~70%' }
nnoremap <silent> <Leader>p :Files<CR>

let g:fzf_colors = 
\ { 'fg':       ['fg', 'Normal'],
\   'bg':       ['bg', 'Normal'],
\   'hl':       ['bg', 'Comment'],
\   'fg+':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\   'bg+':      ['bg', 'CursorLine', 'CursorColumn'],
\   'hl+':      ['fg', 'Statement'],
\   'info':     ['fg', 'PreProc'],
\   'border':   ['fg', 'Ignore'],
\   'prompt':   ['fg', 'Conditional'],
\   'pointer':  ['fg', 'Exception'],
\   'marker':   ['fg', 'Keyword'],
\   'spinner':  ['fg', 'Label'],
\   'header':   ['fg', 'Comment'] }

let $BAT_THEME='TwoDark'
