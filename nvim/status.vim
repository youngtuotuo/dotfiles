" status line setting
" function! MyFiletype() abort
"   return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
" endfunction
"
function! MyFileformat() abort
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) . ' ' . &fileformat . ' ': ''
endfunction

function! FileSize()
   let bytes = getfsize(expand("%:p"))
   if bytes <= 0
       return "0 B"
   endif
   if bytes < 1024
       return bytes . " B"
   else
       return (bytes / 1024) . " KB"
   endif
endfunction

function! Server()
   let ft = &filetype
   if ft == "python"
      return WebDevIconsGetFileTypeSymbol() .. " pyright"
   endif
   if ft == "vim"
      return WebDevIconsGetFileTypeSymbol() .. " vimls"
   endif
   if ft == "bash"
      return WebDevIconsGetFileTypeSymbol() .. " bashls"
   endif
   if ft == "yaml"
      return WebDevIconsGetFileTypeSymbol() .. " yamlls"
   endif
endfunction

" function! Version()
"    return 'NVIM-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*') .. ' '
" endfunction

function! Lspinfo()
   let server = Server()
   if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
      if luaeval("vim.lsp.buf.server_ready()")
         return server
      else
         return serevr .. " not ready"
      endif
   else
      return "Lsp not found"
   endif
endfunction

function! Git()
   let branch = FugitiveHead()
   return strlen(branch) ? branch : ""
endfunction


" func! NvimGps() abort
"     return luaeval("require'nvim-gps'.is_available()") ?
"     \ luaeval("require'nvim-gps'.get_location()") : ''
" endf


" :h mode() to see all modes
let g:currentmode={
    \ 'n'      : 'NORMAL',
    \ 'no'     : 'N·Operator Pending',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'V·Line',
    \ "\<C-V>" : 'V·Block',
    \ 's'      : 'Select',
    \ 'S'      : 'S·Line',
    \ "\<C-S>" : 'S·Block',
    \ 'i'      : 'INSERT',
    \ 'R'      : 'RESEARCH',
    \ 'Rv'     : 'V·Replace',
    \ 'c'      : 'Command',
    \ 'cv'     : 'Vim Ex',
    \ 'ce'     : 'Ex',
    \ 'r'      : 'Prompt',
    \ 'rm'     : 'More',
    \ 'r?'     : 'Confirm',
    \ '!'      : 'Shell',
    \ 't'      : 'Terminal'
    \}


hi User1 gui=standout

hi StatusLine guibg=NONE
hi StatusLineNC guibg=NONE
set statusline=
set statusline+=%1*
set statusline+=\ %{toupper(g:currentmode[mode()])}\ 
" set statusline+=%{mode()}
set statusline+=%#StatusLine#
" set statusline+=\ %{%FileSize()%}\ 
set statusline+=\ %t
" set statusline+=%1*
" set statusline+=%3*
set statusline+=\ %{%Git()%}
set statusline+=\ %{get(b:,'gitsigns_status','')}
" set statusline+=%3*
" set statusline+=%1*
set statusline+=\ %h%w%m%r
" set statusline+=%#StatusLine#
set statusline+=%=
" set statusline+=\ %{NvimGps()}\ 
set statusline+=%1*
set statusline+=\ %l,%c%V\ %P\ 
augroup StHighlight
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setl statusline=%1*\ %{toupper(g:currentmode[mode()])}\ %#StatusLine#\ %{%Git()%}\ %{get(b:,'gitsigns_status','')}\ %h%w%m%r%=%1*\ %l,%c%V\ %P\ 
  autocmd WinLeave * setl statusline=%#StatusLineNC#\ %{%Git()%}\ %{get(b:,'gitsigns_status','')}\ %h%w%m%r%=\ %l,%c%V\ %P\ 
augroup END
" set statusline+=%=%-14.(%l,%c%V%)\ %P
" set statusline+=%#PmenuSel#
" set statusline+=[%n]
" set statusline+=
" set statusline+=\ [
" set statusline+=%{%FileSize()%}
" set statusline+=]
" set statusline+=\ %{%Git()%}
" set statusline+=\ ‹‹
" set statusline+=%2*
" set statusline+=%1*
" set statusline+=\ %t
" set statusline+=\ ››
" set statusline+=\ -
" set statusline+=\ (%l/%L)
" set statusline+=\ %r%h%w%q%m
" set statusline+=%=
" set statusline+=%3*
" set statusline+=\ %{%Version()%}
" set statusline+=%1*
" set statusline+=\ %{%MyFileformat()%}
" set statusline+=%3*
" set statusline+=\ %{%Lspinfo()%}
" set statusline+=\ 
" set statusline+=\ %{%WebDevIconsGetFileTypeSymbol()%}
" set statusline+=%#StatusLine#
" set statusline+=\ %{%Version()%}
" set statusline+=%1*

