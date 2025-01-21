filetype plugin indent on
syntax on
hi Comment ctermfg=green guifg=green
set mouse=nvi nu rnu ruler showmatch noswapfile autoread undofile
set hlsearch incsearch ttimeout ttimeoutlen=50 colorcolumn=120
set history=10000 shortmess-=S
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

autocmd! BufRead,BufNewFile *.typ set filetype=typst
