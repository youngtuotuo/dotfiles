set mouse=a
set t_Co=256
" Set line number

set nu
set rnu
set title
set noerrorbells
set novisualbell
set showmode
set noswapfile
set nobackup
set cursorline
set colorcolumn=100
" Parathensis match
set showmatch
set matchtime=1
" Search control
set ignorecase
set smartcase
" Split control
set splitbelow
set splitright
" tab control
set expandtab
set tabstop=4
set shiftwidth=4
set viminfo='1000
set softtabstop=4
set autoindent
syntax enable
" avoid finger not leave shift
command! W write
" Some servers have issues with backup files, see #649.
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" error and warning msg in line number column
set signcolumn=no
runtime ./plugs.vim
runtime ./maps.vim

