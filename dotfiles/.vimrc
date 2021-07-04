set encoding=utf-8

" Let tmux behave normally
set t_Co=256
set background=dark

" Display extra whitespace
set list listchars=tab:>·,trail:·,nbsp:·

" Set line number
set nu
set rnu

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

" Keep code folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

set autoindent smartindent
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab

syntax on

set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'wombat'
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

