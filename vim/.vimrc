set nocompatible
set ignorecase
set smartcase
set smartindent
set showmatch
set matchtime=1
set backspace=indent,eol,start
set completeopt=menu,menuone,preview
set noswapfile
set complete-=i
set smarttab
syntax on
filetype plugin indent on
set mouse=nvi
set ai
set sessionoptions-=options
set viewoptions-=options
set incsearch
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
set autoread
set history=1000
set ruler
set background=dark
set nolangremap
set cursorline

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis

function! s:SetHL()
    hi CursorLine ctermbg=235 guibg=Grey cterm=nocombine gui=nocombine
    hi CursorLineNr ctermfg=11 guifg=Yellow cterm=nocombine gui=nocombine
    hi Comment guifg=DarkGrey ctermfg=DarkGrey
    hi NormalFloat guibg=NONE ctermbg=NONE
    hi FloatBorder guibg=NONE ctermbg=NONE
    hi StatusLineNC gui=reverse cterm=reverse
    hi! link MatchParen Visual
    hi VertSplit cterm=reverse gui=reverse
    hi Visual guifg=NONE ctermfg=NONE guibg=Grey ctermbg=Grey gui=nocombine cterm=nocombine
    hi Pmenu guibg=Grey ctermbg=Grey
    hi PmenuSel guifg=Black guibg=DarkGrey ctermfg=Black ctermbg=DarkGrey
    hi netrwMarkFile ctermfg=Brown guifg=Brown
endfunction

augroup Tuo
    autocmd!
    autocmd ColorScheme * call s:SetHL()
augroup END

call s:SetHL()

runtime ftplugin/man.vim

nnoremap d_ d^
nnoremap c_ c^
inoremap , ,<C-g>u
inoremap . .<C-g>u
tnoremap <C-[> <C-\><C-n>
nnoremap Y y$
nnoremap J mzJ`z
vnoremap p "_dP
nnoremap <M-j> <cmd>move+1<cr>
nnoremap <M-k> <cmd>move--1<cr>
vnoremap J <cmd>move >+1<cr>gv=gv
vnoremap K <cmd>move <-1<cr>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap <C-x>c :term 

function! ToggleQuickfix()
    let windows = getwininfo()
    for win in windows
        if win.quickfix == 1 && win.loclist == 0
            cclose
            return
        endif
    endfor
    copen
endfunction
nnoremap <nowait><silent> <leader>p :call ToggleQuickfix()<cr>
nnoremap <nowait><silent> ]p :try <bar> cnext <bar> catch <bar> cfirst <bar> endtry<cr>
nnoremap <nowait><silent> [p :try <bar> cprev <bar> catch <bar> clast <bar> endtry<cr>
nnoremap <nowait><silent> <leader>q :call ToggleQuickfix()<cr>
nnoremap <nowait><silent> ]q :try <bar> cnext <bar> catch <bar> cfirst <bar> endtry<cr>
nnoremap <nowait><silent> [q :try <bar> cprev <bar> catch <bar> clast <bar> endtry<cr>

function! ToggleLocationList()
    let windows = getwininfo()
    for win in windows
        if win.loclist == 1
            lclose
            return
        endif
    endfor
    if len(getloclist(0)) > 0
        lopen
    else
        echohl WarningMsg | echo "[WARN] No location list." | echohl None
    endif
endfunction
nnoremap <nowait><leader>l :call ToggleLocationList()<CR>
nnoremap <nowait><silent> ]l :try <bar> lnext <bar> catch <bar> lfirst <bar> endtry<cr>
nnoremap <nowait><silent> [l :try <bar> lprev <bar> catch <bar> llast <bar> endtry<cr>
