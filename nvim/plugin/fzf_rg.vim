" fzf and ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.cache,.clangd,.git}/*"'
let g:fzf_layout = {'window' : {'width': 0.95, 'height' : 0.9}}
" let g:fzf_layout = {'down' : '~70%' }
nnoremap <silent> <Leader>p :Files<CR>
