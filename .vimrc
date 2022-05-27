syntax on
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set ai
set mouse=a
set backspace=eol,indent,start
set noerrorbells
set novisualbell
set hlsearch
set ruler
set splitbelow
set splitright
set showmatch
set matchtime=1
set nowrap
set viminfo='1000
set ignorecase
set smartcase
set noswapfile
set nobackup
set hidden
set laststatus=0
" netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_bufsettings = 'nocursorline'

"james powell python3
vnoremap <leader>p :w ! python3<CR>
" g++ compile and execute
nnoremap <leader>g+ :!g++ -o vimpp.out % && ./vimpp.out<CR>
nnoremap <leader>gc :!gcc -o vimc.out % && ./vimc.out<CR>

" format json
command! FormatJSON %!python -m json.tool

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
" avoid finger not leave shift
" command! W write
" command! Q quit
" command! X xit
" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
" bracket complete
inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O
" keep visual block selection
vmap > >gv
vmap < <gv
" number line
nnoremap <leader>ss :set invnu invrnu<CR>
" Tab navigation like Firefox.
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>
nnoremap tn :tabnew<CR>
" Y like C,D
nnoremap Y y$
nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
" Y like C,D
nnoremap Y y$
nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
" line moving in normalmode, insertmode, visualmode with autoindent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m -2<CR>==i
inoremap <C-j> <esc>:m +1<CR>==i
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
"Jump list mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count: "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count: "") . 'j'

" line moving in normalmode, insertmode, visualmode with autoindent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m -2<CR>==i
inoremap <C-j> <esc>:m +1<CR>==i
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" ctrl-s to save
nnoremap <c-s> :w<cr>
vnoremap <c-s> <c-c>:w<cr>
inoremap <c-s> <esc>:w<cr>

"Jump list mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count: "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count: "") . 'j'

" fixlist
nnoremap co :copen<CR>
nnoremap cc :cclose<CR>
nnoremap cn :cnext<CR>zz
nnoremap cp :cprev<CR>zz

call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-sensible'
" yank highlight
Plug 'machakann/vim-highlightedyank'
" formatter
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" git
Plug 'tpope/vim-fugitive'
" comment
Plug 'tpope/vim-commentary'
call plug#end()

set formatoptions-=cro

hi VertSplit ctermfg=White ctermbg=NONE guifg=White guibg=NONE
hi Comment ctermfg=Green cterm=NONE guifg=Green gui=NONE
hi ModeMsg ctermfg=White ctermbg=NONE cterm=bold guifg=White guibg=NONE gui=bold
hi Search cterm=reverse gui=reverse
hi Pmenu ctermfg=White ctermbg=NONE guifg=White guibg=NONE 
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=NONE

