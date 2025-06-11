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

colo unokai

if has('win32')
    set guioptions-=t
    &undodir = $HOME .. "\\vimfiles\\undo\\"
else
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
nnoremap n nzz
nnoremap N Nzz
map Q gq
sunmap Q

packadd! matchit
packadd! cfilter
packadd! comment
packadd! nohlsearch
packadd! hlyank
packadd! helptoc
if !has('win32')
    runtime ftplugin/man.vim
endif

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

plugpac#Begin()
Pack "tpope/vim-fugitive"
Pack "tpope/vim-rsi"
Pack "tpope/vim-surround"
Pack "tpope/vim-characterize"
Pack "tpope/vim-unimpaired"
Pack "tpope/vim-repeat"
Pack "tpope/vim-speeddating"
Pack "tpope/vim-abolish", { "on": "Abolish"}
Pack "tpope/vim-dispatch", { "on": [ "Dispatch", "Make" ] }
Pack "markonm/traces.vim"
Pack "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Pack "junegunn/gv.vim", { "on": "GV" }
Pack "junegunn/fzf", { "on": "FZF", "do": { -> fzf#install() } }
Pack "junegunn/vim-easy-align", { "on": "EasyAlign" }
Pack "czheo/mojo.vim", { "for": "mojo" }
Pack "easymotion/vim-easymotion"
Pack "mbbill/undotree", { "on": "UndotreeToggle" }
Pack "mhinz/vim-startify"
Pack "mhinz/vim-signify"
Pack "wellle/targets.vim"
Pack "terryma/vim-expand-region"
Pack "jeetsukumaran/vim-pythonsense"
Pack "tommcdo/vim-exchange"
Pack "kaarmu/typst.vim"
Pack "habamax/vim-dir"
plugpac#End()

nnoremap - <cmd>Dir<cr>

nnoremap <nowait> gru :UndotreeToggle<cr>

g:plug_window = "vertical new"

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = "8088"

g:fzf_layout = { "down": "40%" }

g:splitjoin_split_mapping = ""
g:splitjoin_join_mapping = ""

g:startify_change_to_dir = 0
g:startify_change_to_vcs_root = 1
g:startify_change_cmd = "cd"
g:startify_enable_special = 0
g:startify_lists = [ { "type": "files", "header": ["   MRU"] } ]

nnoremap <leader><Enter> <Plug>(expand_region_expand)
nnoremap <leader><Backspace> <Plug>(expand_region_shrink)
vnoremap <leader><Enter> <Plug>(expand_region_expand)
vnoremap <leader><Backspace> <Plug>(expand_region_shrink)


def SetAbolish(): void
    iab """ """<cr>"""<up>
    Abolish teh the
    cab Q q
    cab Qa qa
    cab QA qa
    cab W w
    cab WQ wq
    cab WA wa
    cab Wq wq
    cab Wa wa
    cab Fzf FZF
    cab FZf FZF
enddef

augroup Enter
    autocmd!
    autocmd VimEnter * SetAbolish()
augroup END
