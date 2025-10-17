source $VIMRUNTIME/defaults.vim
syntax on
filetype plugin indent on
set mouse=nvi showmatch noswapfile autoread undofile incsearch formatoptions+=jro
set nowrap history=1000 shortmess-=S background=dark termguicolors shiftwidth=4
set expandtab smartindent autoindent scrolloff=5 hlsearch sidescroll=3 sidescrolloff=2
set ttymouse=sgr laststatus=2 cursorline

set t_BE=[?2004h
set t_BD=[?2004l
set t_PS=[200~
set t_PE=

let &undodir = $HOME . "/.local/state/vim/undo/"

inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z
nnoremap Y y$

packadd cfilter
packadd comment
packadd nohlsearch
packadd hlyank
packadd helptoc

function! GetTODO()
    let commentstring = &l:commentstring
    let comment_prefix = substitute(commentstring, "\s*%s\s*", "", "")
    execute "lvim /" . comment_prefix . "\\s*\\(TODO\\|WARN\\|WARNING\\|NOTE\\)/ % | lwindow"
endfunction

nnoremap gt :call GetTODO()<CR>

autocmd BufReadPre *.asm let g:asmsyntax = "fasm"

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :execute 'lvim /^\(#.*\)\@!\(class\\|\s*def\\|\s*async\sdef\)/ % \| lwindow'<CR>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

augroup c
    autocmd!
    autocmd FileType c setlocal makeprg=cc\ %\ -o\ /dev/null
augroup END

augroup cuda
    autocmd!
    autocmd FileType cuda setlocal makeprg=nvcc\ %\ -o\ /dev/null
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
augroup END

augroup md
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO :execute 'lvim /^#\+\(.*\)/ % \| lope'<CR>
    autocmd FileType markdown setlocal expandtab tabstop=4
augroup END
