set mouse=a
set nu
set rnu
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set noerrorbells
set novisualbell
set scrolloff=3
set hidden
set cursorline
" set cursorcolumn
" set noshowmode
set noswapfile
set nobackup
" set breakindent
filetype plugin indent on
let g:netrw_liststyle = 0
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
set textwidth=120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set nowrap
set viminfo='1000
" avoid finger not leave shift
command! W writes
command! Q quit
" Some servers have issues with backup files
set nowritebackup
" Give more space for displaying messages
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set termguicolors
syntax on
" error and warning msg in line number column
set signcolumn=auto:2
let g:highlightedyank_highlight_duration = 300

" dvc
autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml

runtime plugs.vim
" lsp related
runtime plugscfg/cmpcfg.vim
runtime plugscfg/lspcfg.vim
runtime plugscfg/telescopecfg.vim
runtime plugscfg/indentlinecfg.vim
runtime plugscfg/gitsignscfg.vim
runtime plugscfg/zenmodecfg.vim
runtime plugscfg/todo.vim
" color related
runtime plugscfg/lualine.vim
runtime plugscfg/treesittercfg.vim
runtime highlight.vim
" mapping
runtime maps.vim

" set fillchars+=vert:\|
