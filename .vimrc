set nocompatible
set ignorecase
set smartcase
set showmatch
set matchtime=1
set backspace=indent,eol,start
set complete-=i
set smarttab
set hlsearch
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ai
set number
set sessionoptions-=options
set viewoptions-=options
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
set ruler
set rnu
set nu
set background=dark
set nolangremap
hi Comment guifg=DarkGrey ctermfg=DarkGrey
hi NormalFloat guibg=NONE ctermbg=NONE
hi FloatBorder guibg=NONE ctermbg=NONE
hi StatusLineNC gui=reverse cterm=reverse
hi! link MatchParen Visual
hi VertSplit cterm=reverse gui=reverse
hi Visual guifg=NONE ctermfg=NONE guibg=Grey ctermbg=Grey
hi Pmenu guibg=Grey ctermbg=Grey
hi PmenuSel guifg=Black guibg=DarkGrey ctermfg=Black ctermbg=DarkGrey
hi netrwMarkFile ctermfg=Brown guifg=Brown
runtime ftplugin/man.vim

nnoremap d_ d^
nnoremap c_ c^
inoremap , ,<C-g>u
inoremap . .<C-g>u
tnoremap <C-[> <C-\><C-n>
nnoremap Y y$
nnoremap J mzJ`z
vnoremap p "_dP
nnoremap <M-j> <cmd>move+1<cr>
nnoremap <M-k> <cmd>move--1<cr>
vnoremap J <cmd>move >+1<cr>gv=gv
vnoremap K <cmd>move <-1<cr>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap <C-x>c :term 
nnoremap <nowait> ]p :try <bar> cnext <bar> catch <bar> cfirst <bar> endtry<cr>
nnoremap <nowait> [p :try <bar> cprev <bar> catch <bar> clast <bar> endtry<cr>
