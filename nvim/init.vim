set mouse=a
set t_Co=256
set nu
set rnu
set guicursor=a:blinkwait700-blinkoff400-blinkon100,i-ci-ve:ver25,r-cr-o:hor20
set noerrorbells
set novisualbell
set noshowmode
set noswapfile
set nobackup
set breakindent
let g:netrw_liststyle = 1
let g:netrw_sort_by = "exten"
" set cursorline
" set colorcolumn=100
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
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set viminfo='1000
set softtabstop=4
" set startofline
syntax enable
if (has("termguicolors"))
  set termguicolors
endif
command! W writes " avoid finger not leave shift
set nowritebackup " Some servers have issues with backup files.
set cmdheight=1 " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" error and warning msg in line number column
set signcolumn=auto
runtime ./maps.vim
runtime ./plugs.vim
runtime ./status.vim
runtime ./tabline.vim
autocmd! BufNewFile,BufRead Dvcfile,*.dvc,dvc.lock setfiletype yaml
" set fillchars+=vert:│
set fillchars+=vert:\|
hi VertSplit ctermbg=NONE cterm=NONE guifg=NONE gui=standout
hi Normal guibg=NONE
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
highlight LspReferenceText guibg=NONE gui=standout
highlight LspReferenceRead guibg=NONE gui=standout
highlight LspReferenceWrite guibg=NONE gui=standout
highlight DiagnosticSignError guifg=#E06C75
highlight DiagnosticSignWarn guifg=#E5C07B
highlight DiagnosticSignInfo guifg=NONE
highlight DiagnosticSignHint guifg=NONE
highlight DiagnosticFloatingError guifg=#E06C75
highlight DiagnosticFloatingWarn guifg=#E5C07B
highlight DiagnosticFloatingInfo guifg=NONE
highlight DiagnosticFloatingHint guifg=NONE
highlight DiagnosticVirtualTextError guifg=#E06C75
highlight DiagnosticVirtualTextWarn guifg=#E5C07B
highlight DiagnosticVirtualTextInfo guifg=NONE
highlight DiagnosticVirtualTextHint guifg=NONE
highlight DiagnosticUnderlineError guifg=#E06C75
highlight DiagnosticUnderlineWarn guifg=#E5C07B
highlight DiagnosticUnderlineInfo guifg=NONE
highlight DiagnosticUnderlineHint guifg=NONE
