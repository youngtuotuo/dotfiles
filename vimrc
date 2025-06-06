vim9script
filetype plugin indent on
set mouse=nvi ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=100 formatoptions+=jro nowrap
set history=1000 shortmess-=S shiftwidth=4 expandtab smartindent autoindent
set showcmd laststatus=2 wildmenu scrolloff=5 hlsearch termguicolors
set sidescroll=3 sidescrolloff=2 display=lastline,truncate
set ttymouse=sgr
set nrformats-=octal
set nolangremap
&undodir = $HOME .. "/.local/state/vim/undo/"

if has('win32')
    set guioptions-=t
endif

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

set background=dark
syntax reset
hi clear

hi Normal         guifg=#d3b58d guibg=#072626 ctermfg=180 ctermbg=22
hi Comment        guifg=#3fdfaf                ctermfg=80
hi String         guifg=#0fdfaf                ctermfg=79
hi Keyword        guifg=#ffffff                ctermfg=255
hi Function       guifg=#ffffff                ctermfg=255
hi Identifier     guifg=#c8d4ec                ctermfg=189
hi Type           guifg=#ffffff                ctermfg=255
hi Statement      guifg=#ffffff                ctermfg=255
hi PreProc        guifg=LightGreen            ctermfg=10
hi Constant       guifg=#0fdfaf                ctermfg=79
hi Special        guifg=LightGreen            ctermfg=10
hi SpecialKey     guifg=#3fdfaf                ctermfg=80
hi Number         guifg=#0fdfaf                ctermfg=79
hi Boolean        guifg=#0fdfaf                ctermfg=79
hi Float          guifg=#0fdfaf                ctermfg=79
hi Todo           guifg=#504038                ctermfg=238
hi Error          guifg=#ff0000 guibg=#072626  ctermfg=196 ctermbg=22
hi Warning        guifg=#504038                ctermfg=238
hi Search         guifg=#000080 guibg=#2f8b57  ctermfg=4 ctermbg=29
hi IncSearch      guifg=#000080 guibg=#2f8b57  ctermfg=4 ctermbg=29
hi MatchParen     guifg=#000080 guibg=#2f8b57  ctermfg=4 ctermbg=29
hi StatusLine     guifg=#d3b58d guibg=#072626  ctermfg=22 ctermbg=180
hi StatusLineNC   guifg=#696969 guibg=#2f2f2f  ctermfg=242 ctermbg=236
hi LineNr         guifg=#696969 guibg=#041818  ctermfg=242 ctermbg=234
hi CursorLineNr   guifg=#d3b58d guibg=#041818  ctermfg=180 ctermbg=234
hi Cursor         guifg=#072626 guibg=#90ee90  ctermfg=22 ctermbg=120
hi CursorLine     guibg=#0a2d2d                ctermbg=235
hi CursorColumn   guibg=#0a2d2d                ctermbg=235
hi Folded         guifg=#696969 guibg=#041818  ctermfg=242 ctermbg=234
hi FoldColumn     guifg=#696969 guibg=#041818  ctermfg=242 ctermbg=234
hi DiffAdd        guifg=#ffffff guibg=#005500  ctermfg=255 ctermbg=22
hi DiffChange     guifg=#ffffff guibg=#555500  ctermfg=255 ctermbg=58
hi DiffDelete     guifg=#ffffff guibg=#550000  ctermfg=255 ctermbg=52
hi DiffText       guifg=#ffffff guibg=#777700  ctermfg=255 ctermbg=94
hi Pmenu          guifg=#d3b58d guibg=#2f2f2f  ctermfg=180 ctermbg=236
hi PmenuSel       guifg=#072626 guibg=#d3b58d  ctermfg=22 ctermbg=180
hi PmenuSbar      guibg=#555555                ctermbg=240
hi PmenuThumb     guibg=#888888                ctermbg=244
hi TabLine        guifg=#696969 guibg=#2f2f2f  ctermfg=242 ctermbg=236
hi TabLineFill    guifg=#696969 guibg=#2f2f2f  ctermfg=242 ctermbg=236
hi TabLineSel     guifg=#d3b58d guibg=#072626  ctermfg=180 ctermbg=22
hi SpellBad       guisp=#ff0000 gui=undercurl  cterm=underline
hi SpellCap       guisp=#0000ff gui=undercurl  cterm=underline
hi SpellLocal     guisp=#008b8b gui=undercurl  cterm=underline
hi SpellRare      guisp=#ff00ff gui=undercurl  cterm=underline
hi Directory      guifg=#0fdfaf                ctermfg=79
hi Title          guifg=#ffffff gui=bold       ctermfg=255 cterm=bold
hi MoreMsg        guifg=#90ee90                ctermfg=120
hi Question       guifg=#90ee90                ctermfg=120
hi WarningMsg     guifg=#504038                ctermfg=238
hi ErrorMsg       guifg=#ff0000 guibg=#072626  ctermfg=196 ctermbg=22

const data_dir: string = "~/.vim"
if empty(glob(data_dir .. "/autoload/plug.vim"))
  silent execute "!curl -fLo "..data_dir.."/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
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
plug#end()

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
g:startify_lists = [
  { "type": "files",     "header": ["   MRU"]            },
]

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
