call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }
Plug 'zchee/deoplete-go', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'majutsushi/tagbar'
Plug 'machakann/vim-highlightedyank'
Plug 'buoto/gotests-vim'

" Add plugins to &runtimepath
call plug#end()

" neomake

autocmd! BufWritePost * Neomake

let g:neomake_open_list = 2
let g:deoplete#enable_at_startup = 1
let g:neomake_cpp_clang_maker = {
            \ 'exe': 'clang++',
            \ 'args': ['-fsyntax-only', '-Wall', '-Wextra', '-std=c++11'],
            \ }


nnoremap <C-g> :Neomake<CR>

" color theme
colorscheme jellybeans
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
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set writebackup

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable syntasic
let g:airline_enable_syntastic=1
" Set theme
let g:airline_theme='jellybeans'

" Set leader to space
let mapleader = ' '

" spell check
nnoremap <leader>S :setlocal spell spelllang=ru,en<cr>

" tagbar
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
    \ }
nmap <leader>T :TagbarToggle<CR>
autocmd FileType python,cpp,c,go :TagbarOpen

" Autoformat
nmap <leader>F :Autoformat<CR>

" go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_term_mode = "split"
let g:go_term_enabled = 1

     let g:neomake_error_sign = {'text': 'x', 'texthl': 'NeomakeErrorSign'}
     let g:neomake_warning_sign = {
         \   'text': '!',
         \   'texthl': 'NeomakeWarningSign',
         \ }
     let g:neomake_message_sign = {
          \   'text': '➤',
          \   'texthl': 'NeomakeMessageSign',
          \ }
     let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

let g:neomake_go_enabled_makers = ['go', 'govet']


" some configerator stuff
au BufRead,BufNewFile *.mcconf set filetype=python
au BufRead,BufNewFile *.cconf set filetype=python
au BufRead,BufNewFile *.cinc set filetype=python
