call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Add plugins to &runtimepath
call plug#end()

" color theme
colorscheme catppuccin-mocha
let g:rehash256 = 1

" general behavior
set hidden
set hlsearch      " highlight search
set tabstop=4
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab     " convert tabs to spaces
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  " case-sensitive otherwise
" set title       " change the terminal's title

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable syntasic
let g:airline_enable_syntastic=1
" Set theme
let g:airline_theme='catppuccin'

" Set leader to space
let mapleader = ' '

" spell check
nnoremap <leader>S :setlocal spell spelllang=en<cr>
