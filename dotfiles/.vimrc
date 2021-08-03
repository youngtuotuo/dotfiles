set encoding=utf-8

" Display extra whitespace
set list listchars=tab:>·,trail:·,nbsp:·
" Execute the .vimrc of the working directory if it exists
set exrc
" Set line number
set nu
set rnu

set noerrorbells
" Not behave like vi
set nocompatible
set wildmenu
set title

set nobackup
set novisualbell

" Display cursor position in the lower right corner of the screen
set ruler

set showcmd
set backspace=indent,eol,start

set noshowmode

set noswapfile
set nobackup

" Parathensis match
set showmatch
set matchtime=1

set hlsearch
set incsearch

set ignorecase
set smartcase

" Split controlling
set splitbelow
set splitright

set autoindent smartindent
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Default color scheme
" colorscheme ron

packadd! onedark.vim
if (has("termguicolors"))
  set termguicolors
endif
syntax on
colorscheme onedark

set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \   },
    \ }

" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>

" Tab switch to previous
map gb gT

" Pane resize
map + <C-W>+
map - <C-W>-
map <C-n> <C-W><
map <C-m> <C-W>>
