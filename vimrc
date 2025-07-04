vim9script
syntax on
filetype plugin indent on
set mouse=nvi
set ruler
set showmatch noswapfile autoread undofile
set incsearch
set ttimeout ttimeoutlen=100 formatoptions+=jro
set nowrap
set history=1000 shortmess-=S
set shiftwidth=4 expandtab smartindent autoindent
set showcmd
set wildmenu scrolloff=5 hlsearch
set sidescroll=3 sidescrolloff=2
set display=lastline,truncate
set ttymouse=sgr
set nrformats-=octal
set nolangremap
set background=light
set laststatus=2

if has('win32')
    set guioptions-=t
    &undodir = $HOME .. "\\vimfiles\\undo\\"
else
    runtime ftplugin/man.vim
    &undodir = $HOME .. "/.local/state/vim/undo/"
endif

inoremap <C-c> <ESC>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z
nnoremap Y y$
nnoremap d_ v_d
nnoremap c_ v_c
nnoremap - <cmd>Ex<cr>
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
map Q gq
sunmap Q

iab """ """<cr>"""<up>
ab teh the
ab Teh The
cab Q q
cab Qa qa
cab QA qa
cab W w
cab WQ wq
cab WA wa
cab Wq wq
cab Wa wa

packadd! matchit
packadd! cfilter
packadd! comment
packadd! nohlsearch
packadd! hlyank
packadd! helptoc

def GetTODO(): void
    var commentstring: string = &l:commentstring
    var comment_prefix: string = substitute(commentstring, "\s*%s\s*", "", "")
    feedkeys(":lvim /" .. comment_prefix .. "\\s*\\(TODO\\|WARN\\|WARNING\\|NOTE\\)/ % | lwindow", "n")
enddef

nnoremap gt <scriptcmd>GetTODO()<cr>

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^\(#.*\)\@!\(class\\|\s*def\\|\s*async\sdef\)/ % \| lwindow'<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

augroup c
    autocmd!
    autocmd FileType c setlocal makeprg=cc\ %\ -o\ /dev/null
augroup END

augroup cuda
    autocmd!
    autocmd FileType cuda setlocal makeprg=nvcc\ %\ -o\ /dev/null
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
augroup END

augroup md
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^#\+\(.*\)/ % \| lope'<cr>
    autocmd FileType markdown setlocal expandtab
augroup END

plug#begin()
Plug "tpope/vim-dispatch"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "mbbill/undotree"
plug#end()

nnoremap <nowait> gru :UndotreeToggle<cr>

g:plug_window = "vertical new"

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = "8088"
g:mkdp_theme = 'light'
