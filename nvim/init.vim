set nocompatible
set showmatch
set hlsearch
set incsearch
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set wildmode=longest,list
filetype plugin indent on
syntax on
set mouse=a
filetype plugin on
set cursorline
set ttyfast
set relativenumber


call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

nnoremap <C-t> :NERDTreeToggle<CR>
