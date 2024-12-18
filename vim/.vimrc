set nocompatible
set smartindent
set showmatch
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
set foldopen-=block
colo habamax

if has('win32')
    set guioptions-=t
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
endif

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

runtime ftplugin/man.vim
packadd! matchit
packadd! cfilter

nnoremap d_ d^
nnoremap c_ c^
inoremap , ,<C-g>u
inoremap . .<C-g>u
tnoremap <C-[> <C-\><C-n>
nnoremap Y y$
nnoremap J mzJ`z
vnoremap p "_dP
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
nnoremap <nowait> <leader>p :call ToggleQuickfix()<cr>
nnoremap <nowait> ]p :cnext<cr>
nnoremap <nowait> [p :cprev<cr>

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
let g:netrw_cursor=0
nnoremap <space>o :Tagbar f<CR>
let g:tagbar_width = min([60, winwidth(0) / 3])
let g:tagbar_map_close = "<space>o"

function! s:GetLanIp()
  if has('win32')
    let l:output = system('ipconfig')
    " Find IPv4 address starting with 192
    let l:lan_ip = matchstr(l:output, 'IPv4 Address[^:]*:\s*192\zs\(\.[0-9]\+\)\{3}')
    return '192' . l:lan_ip
  elseif has('mac')
    let l:cmd = 'ipconfig getifaddr en0'
    let l:ip = substitute(system(l:cmd), '\n\+$', '', '')
    return substitute(l:ip, '[[:cntrl:]]', '', 'g')
  elseif has('linux') || has('wsl')
    let l:cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
    let l:ip = system(l:cmd)
    " Remove whitespace
    return substitute(l:ip, '[[:cntrl:][:space:]]', '', 'g')
  endif
endfunction

let g:mkdp_filetypes = ['markdown']
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = s:GetLanIp()
let g:mkdp_browser = ""
let g:mkdp_echo_preview_url = 1
let g:mkdp_browserfunc = ""
let g:mkdp_markdown_css = ""
let g:mkdp_highlight_css = ""
let g:mkdp_port = "8085"
let g:mkdp_page_title = "「${name}」"
let g:mkdp_theme = "light"
autocmd! BufRead,BufNewFile *.typ set filetype=typst
