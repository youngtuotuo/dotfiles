filetype plugin indent on
syntax on
set mouse=nvi nu rnu ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

autocmd! BufRead,BufNewFile *.typ set filetype=typst

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* call clearmatches()
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python_ruff
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :lvim /^\(#.*\)\@!\(class\\|\s*def\)/ %<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END


