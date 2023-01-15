
" Leader
let mapleader=" "

" Tabs and Spaces
au BufNewFile, BufRead *.py
    \ set tabstop=4 softtabstop=4
    \ set shiftwidth=4
    \ set expandtab
    \ set smartindent
    \ set fileformat=unix 
    \ set colorcolumn=80

" Execute local config for different projects
set exrc

" Line Numbering
set relativenumber
set nu

" Search highlights end
set nohlsearch

" keep buffer in the background
set hidden
set noerrorbells
set nowrap

" Saving History
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Scrolling and Searching
set smartcase
set incsearch
set termguicolors
set scrolloff=8

" Columns
set signcolumn=yes

"PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme



set encoding=UTF-8

call plug#end()

" python code settings
syntax on
set t_Co=256
set foldmethod=indent
set foldlevel=99




" Colors
highlight Normal guibg=none
set bg=dark
:colorscheme ayu
