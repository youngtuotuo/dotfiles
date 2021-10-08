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
set colorcolumn=100

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
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'yaegassy/coc-pydocstring', {'do': 'yarn install --frozen-lockfile'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Pydocstring
nmap <silent> ga <Plug>(coc-codeaction-line)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gA <Plug>(coc-codeaction)

" Terminal
tnoremap <Esc> <C-\><C-n>

" python syntax
let g:python_highlight_all = 1

" Vista
let g:vista_sidebar_open_cmd = "30vsplit"
" Executive used when opening vista sidebar without specifying it.
let g:vista_default_executive = 'coc'
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista_sidebar_keepalt = 1
let g:vista#renderer#enable_icon = 1
nnoremap <space>v :Vista!!<CR>

" onedark theme
" hide ~ symbol in lasting line
let g:onedark_hide_endofbuffer = 1
if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark

" lightline configuration
" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
function! NearestMethodOrFunction() abort
  let func = get(b:, 'vista_nearest_method_or_function', '') 
  return  func !=# '' ? ' ' . func : '' 
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"set statusline+=%{NearestMethodOrFunction()}

function! Fileformat()
  return winwidth(0) > 50 ? (WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! Filename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  return WebDevIconsGetFileTypeSymbol() . ' ' . filename
endfunction

function! Modified()
  return &modified ? 'פֿ' : ''
endfunction

function! Git() abort
  let change = get(b:, 'coc_git_status', '')
  let branch = get(g:, 'coc_git_status', '')
  return branch !=# '' ? branch . ' ' . change: ''
endfunction

function! Encode() abort
  return winwidth(0) > 50 ? &fileencoding : ''
endfunction

let g:coc_status_error_sign = ' '

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'git', 'cocstatus', 'method', 'modified','filename'  ] 
    \           ],
    \   'right': [ [ 'fileformat', 'encode'] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'git', 'cocstatus', 'method', 'modified', 'filename' ] ],
    \   'right': [ [ 'fileformat', 'encode' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'method': 'NearestMethodOrFunction',
    \   'fileformat': 'Fileformat',
    \   'filename': 'Filename',
    \   'git': 'Git',
    \   'encode': 'Encode',
    \   'modified': 'Modified',
    \   },
    \ 'mode_map': {
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'v' : 'V',
    \ 'V' : 'VL',
    \ "\<C-v>": 'VB',
    \ 'c' : 'C',
    \ 's' : 'S',
    \ 'S' : 'SL',
    \ "\<C-s>": 'SB',
    \ 't': 'T',
    \ },
    \ }


autocmd User CocGitStatusChange {get(g:,'coc_git_status','')}
autocmd User CocGitStatusChange {get(b:,'coc_git_status','')}

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
nnoremap Y y$
nnoremap { {zz
nnoremap } }zz
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z
inoremap , ,<C-G>u
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-y> <C-y>k^
nnoremap <C-e> <C-e>j^
inoremap <C-j> <esc>:m +1<CR>==i
inoremap <C-k> <esc>:m -2<CR>==i
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
inoremap <C-V> <C-R>"
nnoremap <leader>i %di(i<CR><esc>ko<C-R>"<esc>^:w<CR>
nnoremap <leader><leader> ^DkJJi<C-R>"<esc>%:w<CR>
nnoremap <leader>, f,a<CR><esc>:w<CR>^
nnoremap <C-S> :w<CR>
nnoremap <space>t :terminal<CR>

" Bracket complete
inoremap {<CR> {<CR>}<Esc>ko
inoremap {{ {}<ESC>i
inoremap (<CR> (<CR>)<Esc>ko
inoremap (( ()<ESC>i
inoremap [<CR> [<CR>]<Esc>ko
inoremap [[ []<ESC>i

" Auto quote complete
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i

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

command! W write
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

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=auto
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

" coc search
nnoremap <space>s :CocSearch 

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
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" To get correct comment highlighting for json
autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

" Coc explorer configuration
"let g:netrw_menu = 0
"let g:loaded_netrw= 1
"let g:netrw_loaded_netrwPlugin= 1
"nnoremap <space>e :CocCommand explorer<CR>
"autocmd StdinReadPre * let s:std_in=1
" Start explorer, unless a file or session is specified, eg. vim -S session_file.vim.
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | execute 'CocCommand explorer' | endif

" Coc prettier configuration
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"Coc.nvim configuration"

" NERDTree configuration
"let NERDTreeHighlightCursorline = 0
"nnoremap <space>e :NERDTree<CR>
"nnoremap <space>t :NERDTreeFind<CR>U

" coc fzf preview configuration
nnoremap <space>f :CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <space>b :CocCommand fzf-preview.Buffers<CR>
nnoremap <space>l :CocCommand fzf-preview.BufferLines<CR>
nnoremap <space>g :CocCommand fzf-preview.GitFiles<CR>
nnoremap <space>d :CocCommand fzf-preview.CocDiagnostics<CR>
nnoremap <space>c :Commands<CR>
let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""
