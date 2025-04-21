filetype plugin indent on
syntax on
set mouse=nvi nu rnu ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

autocmd! BufRead,BufNewFile *.typ set filetype=typst

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup WhitespaceHighlight
  autocmd!
  autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
  autocmd ModeChanged n:* call clearmatches()
augroup END
