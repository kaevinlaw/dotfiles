set background=dark
syntax on
set noerrorbells
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set nohlsearch
set shiftwidth=2 tabstop=2 softtabstop=2
set expandtab
set list
set listchars=trail:.
set number
set relativenumber
set exrc
set scrollback=100000

" recursive path when open project at project root
set path+=**

" remaps
" escape
vmap jk <Esc>
imap jk <Esc>

" leader
let mapleader = " "
" such that leader key does not move cursor
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" toggle between last 2 opened files
nnoremap <Leader><Leader> <C-^>

" easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Y yanks till the end of line
map Y y$

" Keep cursor line centered after n/N/J jump
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" move highlighted lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" adds to jump list if jump > 4 rows
nnoremap <expr> k (v:count > 4 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 4 ? "m'" . v:count : "") . 'j'

" horizontal spilt below
set splitbelow
set splitright

" reload config
command! Reload execute "source $MYVIMRC"
command! Config execute "Ex ~/.config/nvim/"

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'liuchengxu/vista.vim'
Plug 'vimwiki/vimwiki'
Plug 'aklt/plantuml-syntax'
Plug 'rhysd/git-messenger.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'will133/vim-dirdiff'
Plug 'Yggdroot/indentLine'
call plug#end()

"colorscheme ron
"colorscheme dracula
"colorscheme desert
colorscheme PaperColor
"colorscheme deep-space
"colorscheme gruvbox
"colorscheme koehler
set bg=dark
highlight normal guibg=NONE
highlight normal ctermbg=NONE
highlight nonText ctermbg=NONE
highlight clear LineNr
highlight clear SignColumn

"set bg=dark
lua require 'colorizer'.setup()

let g:indentLine_char = '|'
