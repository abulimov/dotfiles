set nocompatible       " Be iMproved
filetype off           " required

" vim-plug
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'vim-airline/vim-airline'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()
filetype plugin indent on     " required

" Set leader to space
let mapleader = ' '

" terminal colours
set termguicolors

" spell check
nnoremap <leader>S :setlocal spell spelllang=en<cr>

" sytastic
nnoremap <C-g> :SyntasticCheck<CR>

" color theme
colorscheme catppuccin_mocha

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
set writebackup

" highlight tabs and trailing spaces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\t/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable syntasic
let g:airline_enable_syntastic=1

" syntastic
let g:syntastic_python_python_exe = 'python3'
let g:syntastic_python_checkers = ['pylint', 'pep8']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active' }
" make *.md act as *.markdown
au BufRead,BufNewFile *.md set filetype=markdown

autocmd FileType ruby :setlocal sw=2 ts=2 sts=2     " Two spaces for Ruby files "
autocmd FileType yaml :setlocal sw=2 ts=2 sts=2     " Two spaces for Yaml files "
autocmd FileType ansible :setlocal sw=2 ts=2 sts=2  " Two spaces for Ansible files "
autocmd FileType logstash :setlocal sw=2 ts=2 sts=2 " Two spaces for Logstash files "
autocmd FileType sh :setlocal sw=2 ts=2 sts=2       " Two spaces for Shell files "

" disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
imap <Up> <nop>
imap <Down> <nop>
imap <Left> <nop>
imap <Right> <nop>
