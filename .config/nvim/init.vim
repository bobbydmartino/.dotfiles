
" Leader
let mapleader=" "

" Tabs and Spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

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
set colorcolumn=80

" PLUGINS
set rtp +=~/.vim
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

" Colors
colorscheme gruvbox
highlight Normal guibg=none
set bg=dark

" Add Telescope remaps (TODO)
