set background=dark
filetype plugin indent on
syntax on
set mouse=nvi ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
set showcmd
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

nnoremap <C-c> <ESC>
inoremap <C-c> <ESC>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

nnoremap gt :lvim /TODO/ % \| lope<cr>

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* call clearmatches()
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python_ruff
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :lvim /^\(#.*\)\@!\(class\\|\s*def\)/ % \| lope<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

function! SetupQuickfixSyntax()
    " Clear existing quickfix syntax to avoid conflicts
    syntax clear
    " Match filename (up to the separator │)
    syntax match qfFileName /^[^│]*/ contained containedin=qfLine
    " Match line and column numbers (e.g., 123:45)
    syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
    " Match error/warning type (e.g., ' E' or ' W')
    syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
    " Match the entire valid line
    syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
    " Link highlight groups to default quickfix highlights
    highlight default link qfFileName Directory
    highlight default link qfLineNr LineNr
    highlight default link qfType Type
endfunction

" Define the quickfix text function
function! Qftf(info) abort
    let items = []
    let ret = []

    " Determine if it's a quickfix or location list
    if a:info.quickfix
        let items = getqflist({'id': a:info.id, 'items': 0}).items
    else
        let items = getloclist(a:info.winid, {'id': a:info.id, 'items': 0}).items
    endif

    " Formatting constants
    let limit = 31
    let fnameFmt1 = '%-' . limit . 's'
    let fnameFmt2 = '…%.' . (limit - 1) . 's'
    let validFmt = '%s │%5d:%-3d│%s %s'

    " Process each item in the range
    for i in range(a:info.start_idx - 1, a:info.end_idx - 1)
        let e = items[i]
        let fname = ''
        let str = ''

        if e.valid
            if e.bufnr > 0
                let fname = bufname(e.bufnr)
                if empty(fname)
                    let fname = '[No Name]'
                else
                    let fname = substitute(fname, '^' . $HOME, '~', '')
                endif
                " Truncate fname if too long
                if len(fname) <= limit
                    let fname = printf(fnameFmt1, fname)
                else
                    let fname = printf(fnameFmt2, fname[-limit:])
                endif
            endif
            let lnum = e.lnum > 99999 ? -1 : e.lnum
            let col = e.col > 999 ? -1 : e.col
            let qtype = empty(e.type) ? '' : ' ' . toupper(e.type[0])
            let str = printf(validFmt, fname, lnum, col, qtype, e.text)
        else
            let str = e.text
        endif
        call add(ret, str)
    endfor

    " Schedule the syntax setup
    call timer_start(0, {-> SetupQuickfixSyntax()})

    return ret
endfunction

" Set the quickfixtextfunc option
set qftf=function('Qftf')

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'markonm/traces.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-vinegar'
call plug#end()

let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_port = '8088'
