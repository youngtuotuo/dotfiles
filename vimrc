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

colo sorbet

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
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
map Q gq
sunmap Q

def Setabbr(): void
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
enddef

augroup Enter
    autocmd!
    autocmd VimEnter * Setabbr()
augroup END

packadd! matchit
packadd! cfilter
packadd! comment
packadd! nohlsearch
packadd! hlyank
packadd! helptoc

def GetTODO(): void
    var commentstring: string = &l:commentstring
    var comment_prefix: string = substitute(commentstring, "\s*%s\s*", "", "")
    feedkeys(":lvim /" .. comment_prefix .. "\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope", "n")
enddef

nnoremap gt <scriptcmd>GetTODO()<cr>

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^\(#.*\)\@!\(class\\|\s*def\\|\s*async\sdef\)/ % \| lope'<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

augroup cuda
    autocmd!
    autocmd FileType cuda setlocal makeprg=nvcc\ %
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
augroup END

augroup md
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^#\+\(.*\)/ % \| lope'<cr>
augroup END

plug#begin()
Plug "habamax/vim-dir"
Plug "markonm/traces.vim"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "mbbill/undotree", { "on": "UndotreeToggle" }
Plug "jeetsukumaran/vim-pythonsense"
Plug "kaarmu/typst.vim"
Plug "czheo/mojo.vim", { "for": "mojo" }
Plug "ziglang/zig.vim"
plug#end()

g:zig_fmt_autosave = 0
g:zig_fmt_parse_errors = 0

nnoremap - <cmd>Dir<cr>

nnoremap <nowait> gru :UndotreeToggle<cr>

g:plug_window = "vertical new"

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = "8088"
