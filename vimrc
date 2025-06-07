vim9script
filetype plugin indent on
set mouse=nvi
set ruler
set showmatch noswapfile autoread undofile
set incsearch
set ttimeout ttimeoutlen=100 formatoptions+=jro
set nowrap
set history=1000 shortmess-=S
set shiftwidth=4 expandtab smartindent autoindent
set showcmd laststatus=2
set wildmenu scrolloff=5 hlsearch
set sidescroll=3 sidescrolloff=2
set display=lastline,truncate
set ttymouse=sgr
set nrformats-=octal
set nolangremap
&undodir = $HOME .. "/.local/state/vim/undo/"

if has('win32')
    set guioptions-=t
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
packadd! hlyank

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

runtime ftplugin/man.vim

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

# Define the quickfix text function
def Qftf(info: dict<any>): list<string>
    var items: list<dict<any>> = []
    var ret: list<string> = []

    if info.quickfix
        items = getqflist({"id": info.id, "items": 0}).items
    else
        items = getloclist(info.winid, {"id": info.id, "items": 0}).items
    endif

    const limit: number = 31
    for i: number in range(info.start_idx - 1, info.end_idx - 1)
        var e: dict<any> = items[i]
        var fname: string = ""
        var str: string = ""

        if e.valid && info.quickfix
            var qtype: string = empty(e.type) ? "" : " " .. toupper(e.type[0])
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

# Set the quickfixtextfunc option
set qftf=Qftf

var data_dir: string = ""
if has('win32')
    data_dir = "~/vimfiles"
else
    data_dir = "~/.vim"
endif

if empty(glob(data_dir .. "/autoload/plug.vim"))
    if has('win32')
        silent execute "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force"  
    else
        silent execute "!curl -fLo "..data_dir.."/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    endif
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

plug#begin()
Plug "tpope/vim-fugitive"
Plug "tpope/vim-rsi"
Plug "tpope/vim-surround"
Plug "tpope/vim-characterize"
Plug "tpope/vim-vinegar"
Plug "tpope/vim-unimpaired"
Plug "tpope/vim-repeat"
Plug "tpope/vim-speeddating"
Plug "tpope/vim-abolish", { "on": "Abolish"}
Plug "tpope/vim-dispatch", { "on": [ "Dispatch", "Make" ] }
Plug "AndrewRadev/splitjoin.vim", { "on": [ "SplitjoinJoin", "SplitjoinSplit" ]}
Plug "markonm/traces.vim"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "junegunn/gv.vim", { "on": "GV" }
Plug "junegunn/fzf", { "on": "FZF", "do": { -> fzf#install() } }
Plug "junegunn/vim-easy-align", { "on": "EasyAlign" }
Plug "junegunn/vim-slash"
Plug "czheo/mojo.vim", { "for": "mojo" }
Plug "easymotion/vim-easymotion"
Plug "mbbill/undotree", { "on": "UndotreeToggle" }
Plug "mhinz/vim-startify"
Plug "mhinz/vim-signify"
Plug "wellle/targets.vim"
Plug "terryma/vim-expand-region"
Plug "jeetsukumaran/vim-pythonsense"
Plug "tommcdo/vim-exchange"
Plug "mhinz/vim-janah"
plug#end()

colo janah

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

nnoremap gj :SplitjoinJoin<cr>
nnoremap gs :SplitjoinSplit<cr>
g:highlightedyank_highlight_duration = 150

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

nnoremap <plug>(slash-after) zz<cmd>call slash#blink(2, 50)<cr>
