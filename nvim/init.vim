set mouse=a
set t_Co=256
" set nu
set rnu
set guicursor=a:blinkwait700-blinkoff400-blinkon100,i-ci-ve:ver25,r-cr-o:hor20
set noerrorbells
set novisualbell
set showmode
set noswapfile
set nobackup
set breakindent
let g:netrw_liststyle = 1
let g:netrw_sort_by = "exten"
" set cursorline
" set colorcolumn=100
" Parathensis match
set showmatch
set matchtime=1
" Search control
set ignorecase
set smartcase
" Split control
set splitbelow
set splitright
" <tab> control
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set viminfo='1000
set softtabstop=4
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
set updatetime=400
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" error and warning msg in line number column
set signcolumn=yes:1
runtime ./plugs.vim
runtime ./maps.vim
" hi TabLineSel gui=bold
" hi TabLine gui=bold
hi User1 ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=standout
hi User2 ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=standout
hi User3 ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=NONE
runtime ./status.vim
runtime ./tabline.vim
