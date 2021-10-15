set mouse=a
set t_Co=256
set nu
set rnu
set title
set noerrorbells
set novisualbell
set showmode
set noswapfile
set nobackup
set breakindent
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
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set viminfo='1000
set softtabstop=4
set autoindent
set startofline
syntax enable
if (has("termguicolors"))
  set termguicolors
endif
command! W writes " avoid finger not leave shift
set nowritebackup " Some servers have issues with backup files.
set cmdheight=1 " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" error and warning msg in line number column
set signcolumn=auto:2-5
runtime ./plugs.vim
runtime ./maps.vim
runtime ./status.vim
