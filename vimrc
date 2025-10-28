source $VIMRUNTIME/defaults.vim
syntax on
filetype plugin indent on
set noswapfile autoread undofile formatoptions+=j laststatus=2
set nowrap shortmess-=S background=dark termguicolors shiftwidth=4
set expandtab smartindent autoindent scrolloff=5 hlsearch sidescroll=3 sidescrolloff=2
let &t_BE = "\<Esc>[?2004h"
let &t_BD = "\<Esc>[?2004l"
let &t_PS = "\<Esc>[200~"
let &t_PE = "\<Esc>[201~"
let &undodir = $HOME . "/.local/state/vim/undo/"
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z
nnoremap Y y$
packadd cfilter
augroup group
    autocmd!
    autocmd BufReadPre *.asm let g:asmsyntax = "fasm"
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
    autocmd FileType c setlocal makeprg=cc\ %\ -o\ /dev/null
    autocmd FileType cuda setlocal makeprg=nvcc\ %\ -o\ /dev/null
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
    autocmd FileType markdown setlocal expandtab tabstop=4
augroup END
