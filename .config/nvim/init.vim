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

" Use the system clipboard
set clipboard=unnamed

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
call plug#begin()
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/tpope/vim-commentary' " auto comment
Plug 'https://github.com/tpope/vim-surround' " surround with parentheses etc.
Plug 'https://github.com/tpope/vim-fugitive' " git commands in vim (testing to see if I like it)
Plug 'https://github.com/vim-airline/vim-airline' " airline
Plug 'https://github.com/vim-airline/vim-airline-themes' " themes for vim airline


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
let g:airline_theme='luna'
:colorscheme ayu
