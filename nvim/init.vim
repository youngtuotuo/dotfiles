set mouse=a
" set nu
" set rnu
set guicursor=n-v-c:block,i-ci-ve:block25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set noerrorbells
set novisualbell
set scrolloff=3
set hidden
" set cursorline
set colorcolumn=81
" set noshowmode
set noswapfile
set nobackup
" set breakindent
" netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
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
set nowrap
set viminfo='1000

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Some servers have issues with backup files
set nowritebackup
" Give more space for displaying messages
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=400

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set termguicolors
syntax on

" error and warning msg in line number
set signcolumn=yes:2

let g:highlightedyank_highlight_duration = 300

" dvc
" autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml

runtime plugs.vim
runtime cfg/formatter.vim
" lsp related
runtime cfg/cmpcfg.vim
runtime cfg/lspcfg.vim
runtime cfg/progress.vim
runtime cfg/telescopecfg.vim
runtime cfg/gitsignscfg.vim
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
autocmd FileType cpp,c setlocal shiftwidth=2 softtabstop=2 tabstop=2 smartindent expandtab
" set autoindent
" set cindent
" set tabstop=4
" set shiftwidth=4
" set expandtab
