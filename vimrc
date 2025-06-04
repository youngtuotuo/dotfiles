vim9script
set background=light
filetype plugin indent on
syntax on
set mouse=nvi ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=100 formatoptions+=jro nowrap
set history=1000 shortmess-=S shiftwidth=4 expandtab smartindent autoindent
set showcmd laststatus=2 nu rnu wildmenu scrolloff=5
set sidescroll=3 sidescrolloff=2 display=lastline,truncate
set ttymouse=sgr
&undodir = $HOME .. "/.local/state/vim/undo/"

if !has("gui_running") && &term =~ "^\%(screen\|tmux\)"
    &t_BE = "\<Esc>[?2004h"
    &t_BD = "\<Esc>[?2004l"
    &t_PS = "\<Esc>[200~"
    &t_PE = "\<Esc>[201~"

    &t_fe = "\<Esc>[?1004h"
    &t_fd = "\<Esc>[?1004l"
    execute "set <FocusGained>=\<Esc>[I"
    execute "set <FocusLost>=\<Esc>[O"

    execute "silent! set <xUp>=\<Esc>[@;*A"
    execute "silent! set <xDown>=\<Esc>[@;*B"
    execute "silent! set <xRight>=\<Esc>[@;*C"
    execute "silent! set <xLeft>=\<Esc>[@;*D"
endif

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

if !exists("g:is_posix") && !exists("g:is_bash") && !exists("g:is_kornshell") && !exists("g:is_dash")
    g:is_posix = 1
endif

inoremap <C-c> <ESC>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z
nnoremap Y y$
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

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

def ManShowTOC(): void
  var bufnr: number = bufnr("%")
  var bufname: string = bufname(bufnr)
  var info: dict<any> = getloclist(0, {"winid": 1})

  # Check if location list exists and is associated with current buffer
  if !empty(info) && getwinvar(info.winid, "qf_toc") ==# bufname
    execute "lopen"
    return
  endif

  # Initialize table of contents list
  var toc: list<dict<any>> = []
  var lnum: number = 2
  var last_line: number = line("$") - 1
  while lnum > 0 && lnum < last_line
    var text: string = getline(lnum)
    if text =~ "^\s\+[-+]\S" || text =~ "^   \S" || text =~ "^\S"
      add(toc, {
            "bufnr": bufnr,
            "lnum": lnum,
            "text": substitute(substitute(text, "^\s\+", "", ""), "\s\+$", "", "")
            })
    endif
    lnum = nextnonblank(lnum + 1)
  endwhile

  setloclist(0, toc, " ")
  setloclist(0, [], "a", {"title": "Table of contents"})
  execute "lopen"
  w:qf_toc = bufname
  setlocal filetype=qf
enddef

augroup man
    autocmd!
    autocmd FileType man nnoremap <buffer> <silent> gO <scriptcmd>ManShowTOC()<bar>lope<cr>
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

const data_dir: string = "~/.vim"
if empty(glob(data_dir .. "/autoload/plug.vim"))
  silent execute "!curl -fLo "..data_dir.."/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

plug#begin()
Plug "tpope/vim-commentary"
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
Plug "jeetsukumaran/vim-buffergator", { "on": "BuffergatorToggle" }
Plug "AndrewRadev/splitjoin.vim", { "on": [ "SplitjoinJoin", "SplitjoinSplit" ]}
Plug "markonm/traces.vim"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "junegunn/gv.vim", { "on": "GV" }
Plug "junegunn/fzf", { "on": "FZF", "do": { -> fzf#install() } }
Plug "junegunn/vim-easy-align", { "on": "EasyAlign" }
Plug "czheo/mojo.vim", { "for": "mojo" }
Plug "easymotion/vim-easymotion"
Plug "machakann/vim-highlightedyank"
Plug "mbbill/undotree", { "on": "UndotreeToggle" }
Plug "mhinz/vim-startify"
Plug "mhinz/vim-janah"
Plug "mhinz/vim-signify"
Plug "wellle/targets.vim"
Plug "terryma/vim-expand-region"
Plug "jeetsukumaran/vim-pythonsense"
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

g:buffergator_suppress_keymap = 1
g:buffergator_viewport_split_policy = "B"
g:buffergator_hsplit_size = 10
nnoremap gb :BuffergatorToggle<cr>

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
    Abolish -cmdline Q{,A} q{,a}
    cab Qa qa
    Abolish -cmdline W{,Q,A} w{,q,a}
    cab Wq wq
    cab Wa wa
enddef
 
augroup abolish
    autocmd!
    autocmd VimEnter * SetAbolish()
augroup END
