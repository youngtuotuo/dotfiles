set mouse=a
set noerrorbells
set novisualbell
set laststatus=1
set hidden
set noswapfile
set nobackup
" netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_bufsettings = 'nocursorline'
" Parathensis match
set showmatch
set matchtime=1
" Search control
set ignorecase
set smartcase
" Split control
set splitbelow
set splitright
set nowrap
set viminfo='1000
set showmode

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Some servers have issues with backup files
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=400

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

syntax on

runtime plugs.vim
" lsp related
runtime cfg/cmpcfg.vim
runtime cfg/lspcfg.vim
runtime cfg/telescopecfg.vim
runtime cfg/todo.vim
" color related
runtime cfg/treesittercfg.vim
runtime cfg/color.vim
" markdown
runtime cfg/markdownpreview.vim
" mapping
runtime maps.vim
filetype plugin indent on
" <tab> control
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
autocmd FileType cpp,c setlocal shiftwidth=2 tabstop=2 autoindent expandtab
