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

" Auto quote complete
""inoremap ( ()<Esc>i
""inoremap " ""<Esc>i
""inoremap ' ''<Esc>i
""inoremap [ []<Esc>i
""inoremap { {}<Esc>i

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

" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.2.3183")
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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
""xmap <leader>a  <Plug>(coc-codeaction-selected)
""nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
""nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
""nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
""if has('nvim-0.4.0') || has('patch-8.2.0750')
""  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
""  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
""  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
""  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
""  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
""  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
""endif

" Add `:Format` command to format current buffer.
""command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
""command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
""command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Coc explorer
nnoremap <space>e :CocCommand explorer<CR>

" Mappings for CoCList
" Show all diagnostics.
""nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
""nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
""nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
""nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
""nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
""nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
""nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
""nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Coc prettier configuration
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"Coc.nvim configuration

" NERDTree configuration
"let NERDTreeHighlightCursorline = 0
"nnoremap <space>e :NERDTree<CR>
"nnoremap <space>t :NERDTreeFind<CR>U

" FZF configuration
nnoremap <space>f :Files<CR>
nnoremap <space>b :Buffers<CR>
let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""

