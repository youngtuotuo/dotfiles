set mouse=a
set t_Co=256

" Set line number
set nu
set rnu

set title
set noerrorbells
set novisualbell
set noshowmode
set noswapfile
set nobackup
set cursorline
set colorcolumn=80

" Parathensis match
set showmatch
set matchtime=1

" Search control
set ignorecase
set smartcase

" Split control
set splitbelow
set splitright

" tab control
set autoindent smartindent 
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
filetype indent on

" Indent line configuration
let g:indentLine_char = '▏'

"Plugin manager
call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" python syntax
let g:python_highlight_all = 1

" onedark theme
" hide ~ symbol in lasting line
let g:onedark_hide_endofbuffer = 1
if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark

" lightline configuration
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \   },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'cocstatus': 'coc#status'
    \ },
    \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

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

" Bracket control
inoremap {<CR> {<CR>}<Esc>ko
inoremap {{ {}<ESC>i
inoremap (<CR> (<CR>)<Esc>ko
inoremap (( ()<ESC>i
inoremap [<CR> [<CR>]<Esc>ko
inoremap [[ []<ESC>i

" Pane resize
map <S-Up> <C-W>+
map <S-Down> <C-W>-
map <S-Left> <C-W><
map <S-Right> <C-W>>
map <C-Down> <C-E>
map <C-Up> <C-Y>
map <C-S-Up> <C-U>
map <C-S-Down> <C-D>

" Page naviagtion
map <C-Down> <C-E>
map <C-Up> <C-Y>
map <C-S-Up> <C-U>
map <C-S-Down> <C-D>

" Auto quote complete
""inoremap ( ()<Esc>i
""inoremap " ""<Esc>i
""inoremap ' ''<Esc>i
""inoremap [ []<Esc>i
""inoremap { {}<Esc>i

"Coc.nvim configuration"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-@> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-@> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,python setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" To get correct comment highlighting for json
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

" Coc explorer configuration
let g:netrw_menu = 0
let g:loaded_netrw= 1
let g:netrw_loaded_netrwPlugin= 1
nnoremap <space>e :CocCommand explorer<CR>
autocmd StdinReadPre * let s:std_in=1
" Start explorer, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | execute 'CocCommand explorer' | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'CocCommand explorer' argv()[0] | endif

" Coc prettier configuration
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"Coc.nvim configuration"

" NERDTree configuration
"let NERDTreeHighlightCursorline = 0
"nnoremap <space>e :NERDTree<CR>
"nnoremap <space>t :NERDTreeFind<CR>U

" FZF configuration
nnoremap <space>f :Files<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>w :Windows<CR>
let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""
