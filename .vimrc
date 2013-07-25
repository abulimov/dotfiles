set nocompatible       " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" My Bundles here:
"
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck

" sytastic
let g:haddock_browser = "/usr/bin/firefox"
let g:ghc = "/usr/bin/ghc"
nnoremap <C-g> :SyntasticCheck<CR>
"nnoremap <C-p> :!ansible-playbook -i hosts %

"CtrlP
nnoremap <C-p> :Unite file_rec/async -start-insert<cr>
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_working_path_mode = 'ra'

" color theme
colorscheme solarized
set background=dark


" general behaviour
set hidden
set hlsearch "highlight search
set tabstop=4
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab     "convert tabs to spaces
"set modeline
"set modelines=5
"set copyindent    " copy the previous indentation on autoindenting
"set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
"set title         " change the terminal's title
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set writebackup

"highlight tabs and trailing spaces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\t/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" airline
let g:airline_enable_syntastic=1
let g:airline_theme='solarized'

" syntastic
let g:syntastic_check_on_open=0
"let g:syntastic_loc_list_height=5
"let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active' }


"map russian keys
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

"disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
