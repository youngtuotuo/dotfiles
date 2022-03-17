" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

set mouse=a

" Display extra whitespace
set list listchars=tab:>·,trail:·,nbsp:·

" Execute the .vimrc of the working directory if it exists
set exrc

" Set line number
set nu
set rnu

" netrw setting
" Tree style
""let g:netrw_liststyle = 3
" Remove top banner
""let g:netrw_banner = 0
""let g:netrw_altv = 1
""let g:netrw_winsize = 10
""nnoremap <space>e :Vex<CR>

set nocompatible
set wildmenu
set title
set noerrorbells
set novisualbell
set noshowmode
set noswapfile
set nobackup

" Display cursor position in the lower right corner of the screen
set cursorline

set showcmd
set backspace=indent,eol,start

" Parathensis match
set showmatch
set matchtime=1

" Search control
set hlsearch
set incsearch
set ignorecase
set smartcase

" Split control
set splitbelow
set splitright

" tab control
set autoindent smartindent
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Indent line configuration
let g:indentLine_char = '|'

"Plugin manage
call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" python syntax
let g:python_highlight_all = 1

" onedark theme
" hide ~ symbol in lasting line
"let g:one_dark_termcolors = 16
"if (has("termguicolors"))
"  set termguicolors
"endif
syntax on
colorscheme onedark

" Always has status line
set laststatus=2

" lightline
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \   },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \ },
    \ }

" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>

" gb tab switch to previous
map gb gT

" More reasonable remap
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z
inoremap , ,<C-G>u
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-y> <C-y>k
nnoremap <C-e> <C-e>j

inoremap <C-j> <esc>:m +1<CR>==i
inoremap <C-k> <esc>:m -2<CR>==i
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" Pane resize
map <S-Up> <C-W>+
map <S-Down> <C-W>-
map <S-Left> <C-W><
map <S-Right> <C-W>>

" Pane navigation
map <C-Down> <C-E>
map <C-Up> <C-Y>
map <C-S-Up> <C-U>
map <C-S-Down> <C-D>


"Coc.nvim configuration
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=auto

" FZF configuration
nnoremap <space>f :Files<CR>
nnoremap <space>b :Buffers<CR>
let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""

" hi Normal guibg=NONE
autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml
