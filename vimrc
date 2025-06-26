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
set background=dark
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
augroup END

plug#begin()
Plug "tpope/vim-dispatch"
Plug "mhinz/vim-signify"
Plug "tpope/vim-eunuch"
Plug "markonm/traces.vim"
Plug "iamcco/markdown-preview.nvim", { "do": { -> mkdp#util#install() }, "for": ["markdown", "vim-plug"]}
Plug "mbbill/undotree", { "on": "UndotreeToggle" }
Plug "jeetsukumaran/vim-pythonsense"
Plug "vds2212/vim-remotions"
Plug "piyush-ppradhan/naysayer.vim"
Plug "hardselius/warlock"
plug#end()

colo warlock

nnoremap <nowait> gru :UndotreeToggle<cr>

g:plug_window = "vertical new"

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = "8088"

g:remotions_motions = {
    'TtFf': {},
    'para': { 'backward': '{', 'forward': '}' },
    'sentence': { 'backward': '(', 'forward': ')' },
    'change': { 'backward': 'g,', 'forward': 'g;' },
    'class': { 'backward': '[[', 'forward': ']]' },
    'classend': { 'backward': '[]', 'forward': '][' },
    'method': { 'backward': '[m', 'forward': ']m' },
    'methodend': { 'backward': '[M', 'forward': ']M' },
    
    'line': {
       'backward': 'k',
       'forward': 'j',
       'repeat_if_count': 1,
       'repeat_count': 1
    },
    'displayline': {
       'backward': 'gk',
       'forward': 'gj',
    },
    
    'char': { 'backward': 'h',
       'forward': 'l',
       'repeat_if_count': 1,
       'repeat_count': 1
    },
    
    'word': {
       'backward': 'b',
       'forward': 'w',
       'repeat_if_count': 1,
       'repeat_count': 1
    },
    'fullword': { 'backward': 'B',
       'forward': 'W',
       'repeat_if_count': 1,
       'repeat_count': 1
    },
    'wordend': { 'backward': 'ge',
       'forward': 'e',
       'repeat_if_count': 1,
       'repeat_count': 1
    },
    
    'pos': { 'backward': '<C-i>', 'forward': '<C-o>' },
    
    'page': { 'backward': '<C-u>', 'forward': '<C-d>' },
    'pagefull': { 'backward': '<C-b>', 'forward': '<C-f>' },
    
    'undo': { 'backward': 'u', 'forward': '<C-r>', 'direction': 1 },
    
    'linescroll': { 'backward': '<C-e>', 'forward': '<C-y>' },
    'columnscroll': { 'backward': 'zh', 'forward': 'zl' },
    'columnsscroll': { 'backward': 'zH', 'forward': 'zL' },
    
    'vsplit': { 'backward': '<C-w><', 'forward': '<C-w>>' },
    'hsplit': { 'backward': '<C-w>-', 'forward': '<C-w>+' },
    
    'arg': { 'backward': '[a', 'forward': ']a'},
    'buffer': { 'backward': '[b', 'forward': ']b'},
    'location': { 'backward': '[l', 'forward': ']l'},
    'quickfix': { 'backward': '[q', 'forward': ']q'},
    'tag': { 'backward': '[t', 'forward': ']t'},
    
    'diagnostic': { 'backward': '[g', 'forward': ']g'},
}
