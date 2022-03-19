set mouse=a
set nu
set rnu
set guicursor=n-v-c:block,i-ci-ve:block25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set noerrorbells
set novisualbell
set scrolloff=3
set hidden
set cursorline
" set noshowmode
set noswapfile
set nobackup
" set breakindent
filetype plugin indent on
" netrw
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_localrmdir='rm -r'
let g:netrw_sort_by = "exten"
" set virtualedit=all
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
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vim  setlocal tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set nowrap
set viminfo='1000

" Some servers have issues with backup files
set nowritebackup
" Give more space for displaying messages
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set termguicolors
syntax on

" error and warning msg in line number column
set signcolumn=yes:2

let g:highlightedyank_highlight_duration = 300

" dvc
" autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml

set listchars=eol:↴
set list

runtime plugs.vim
runtime cfg/color.vim
runtime cfg/formatter.vim
" lsp related
runtime cfg/cmpcfg.vim
runtime cfg/lspcfg.vim
runtime cfg/progress.vim
runtime cfg/telescopecfg.vim
runtime cfg/gitsignscfg.vim
runtime cfg/zenmodecfg.vim
runtime cfg/todo.vim
" color related
runtime cfg/treesittercfg.vim
" mapping
runtime maps.vim
set laststatus=3
