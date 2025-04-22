filetype plugin indent on
syntax on
set mouse=nvi nu rnu ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

autocmd! BufRead,BufNewFile *.typ set filetype=typst

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* call clearmatches()
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python_ruff
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :lvim /^\(#.*\)\@!\(class\\|\s*def\)/ %<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

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

    return ret
endfunction

" Set the quickfixtextfunc option
set qftf=function('Qftf')
