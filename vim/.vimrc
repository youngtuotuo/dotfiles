set nocompatible
set smartindent
set showmatch
set undofile
set noswapfile
set display=lastline
set backspace=indent,eol,start
set completeopt=menu,menuone,preview
set complete-=i
set smarttab
syntax on
filetype plugin indent on
set mouse=nvi
set autoindent
set sessionoptions-=options
set viewoptions-=options
set incsearch
set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
set formatoptions+=j
set autoread
set history=10000
set ruler
set background=dark
set nrformats-=octal
set showcmd
set ttimeout
set nowrapscan
map Q gq
sunmap Q

if has('win32')
    set guioptions-=t
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultPar ameterValues[''Out-File:Encoding'']=''utf8'';$PSStyle.OutputRendering=''plaintext'';Remove-Alias -F orce -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
endif

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

function! s:SetHL()
    hi Comment ctermfg=242 guifg=DarkGrey 
    hi NormalFloat ctermbg=NONE guibg=NONE
    hi FloatBorder ctermbg=NONE guibg=NONE
    hi StatusLineNC cterm=reverse gui=reverse
    hi VertSplit cterm=reverse gui=reverse
    hi Visual ctermfg=NONE ctermbg=238 cterm=nocombine guifg=NONE guibg=Grey gui=nocombine
    hi! link MatchParen Visual
    hi Pmenu ctermbg=Grey guibg=Grey 
    hi PmenuSel ctermfg=Black ctermbg=DarkGrey guifg=Black guibg=DarkGrey
    hi netrwMarkFile ctermfg=Brown guifg=Brown
endfunction

call s:SetHL()

augroup Tuo
    autocmd!
    autocmd VimEnter,ColorScheme * call s:SetHL()
augroup END

augroup vimStartup
    autocmd!
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit' && index(['xxd', 'gitrebase'], &filetype) == -1
      \ |   execute "normal! g`\""
      \ | endif
augroup END

runtime ftplugin/man.vim
packadd! matchit

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
nnoremap <nowait><silent> ]p :cnext<cr>
nnoremap <nowait><silent> [p :cprev<cr>

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
        echohl ErrorMsg | echo "E776: No location list" | echohl None
    endif
endfunction
nnoremap <nowait><leader>l :call ToggleLocationList()<CR>
