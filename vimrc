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

augroup cuda
    autocmd!
    autocmd FileType cuda setlocal makeprg=nvcc\ %
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
augroup END

augroup md
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^#\+\(.*\)/ % \| lope'<cr>
augroup END

def SetQuickfixSyntax(): void
    syntax clear
    syntax match qfFileName /^[^│]*/ contained containedin=qfLine
    syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
    syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
    syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
    highlight default link qfFileName Directory
    highlight default link qfLineNr LineNr
    highlight default link qfType Type
enddef

def Qftf(info: dict<any>): list<string>
    var items: list<dict<any>> = []
    var ret: list<string> = []

    if info.quickfix
        items = getqflist({"id": info.id, "items": 0}).items
    else
        items = getloclist(info.winid, {"id": info.id, "items": 0}).items
    endif

    for i: number in range(info.start_idx - 1, info.end_idx - 1)
        var e: dict<any> = items[i]
        var fname: string = ""
        var str: string = ""

        if e.valid && info.quickfix
            if e.bufnr > 0
                fname = bufname(e.bufnr)
                if empty(fname)
                    fname = "[No Name]"
                endif
            endif
            var validFmt: string = "%s | %s"
            str = printf(validFmt, fname, e.text)
        else
            str = e.text
        endif
        add(ret, str)
    endfor

    # Schedule the syntax setup to run asynchronously
    timer_start(0, (_) => SetQuickfixSyntax())
    return ret
enddef

set qftf=Qftf

plug#begin()
Plug "tpope/vim-fugitive"
Plug "tpope/vim-rsi"
Plug "tpope/vim-surround"
Plug "tpope/vim-characterize"
Plug "tpope/vim-unimpaired"
Plug "tpope/vim-speeddating"
Plug "tpope/vim-dispatch"
Plug "tpope/vim-repeat"
Plug "markonm/traces.vim"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "junegunn/gv.vim", { "on": "GV" }
Plug "junegunn/vim-easy-align", { "on": "EasyAlign" }
Plug "czheo/mojo.vim", { "for": "mojo" }
Plug "easymotion/vim-easymotion"
Plug "mbbill/undotree", { "on": "UndotreeToggle" }
Plug "mhinz/vim-startify"
Plug "mhinz/vim-signify"
Plug "wellle/targets.vim"
Plug "terryma/vim-expand-region"
Plug "jeetsukumaran/vim-pythonsense"
Plug "tommcdo/vim-exchange"
Plug "kaarmu/typst.vim"
Plug "habamax/vim-dir"
Plug "ziglang/zig.vim"
plug#end()

xmap gra <Plug>(EasyAlign)
nmap gra <Plug>(EasyAlign)

g:zig_fmt_autosave = 0
g:zig_fmt_parse_errors = 0

nnoremap - <cmd>Dir<cr>

nnoremap <nowait> gru :UndotreeToggle<cr>

g:plug_window = "vertical new"

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = "8088"

g:startify_change_to_dir = 0
g:startify_change_to_vcs_root = 1
g:startify_change_cmd = "cd"
g:startify_enable_special = 0
g:startify_lists = [ { "type": "files", "header": ["   MRU"] } ]

nnoremap <leader><Enter> <Plug>(expand_region_expand)
nnoremap <leader><Backspace> <Plug>(expand_region_shrink)
vnoremap <Enter> <Plug>(expand_region_expand)
vnoremap <Backspace> <Plug>(expand_region_shrink)
