" status line setting
"function! MyFiletype() abort
"  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
"endfunction
"
"function! MyFileformat() abort
"  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) . ' ' : ''
"endfunction
function! FileSize()
   let bytes = getfsize(expand("%:p"))
   if bytes <= 0
       return "0 B"
   endif
   if bytes < 1024
       return bytes
   else
       return (bytes / 1024) . " KB"
   endif
endfunction
hi User1 ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=standout,bold
set statusline=%1*
"set statusline+=%#PmenuSel#
"set statusline+=[%n]
"set statusline+=
set statusline+=\ [
set statusline+=%{%FileSize()%}
set statusline+=]
set statusline+=\ ‹‹
set statusline+=\ %f
set statusline+=\ %{%WebDevIconsGetFileTypeSymbol()%}
set statusline+=\ ››
set statusline+=\ -
set statusline+=\ (%l/%L)
set statusline+=%r%h%w%q
set statusline+=%m
"set statusline+=\ %*
"set statusline+=\ %{%MyFiletype()%}
"set statusline+=%1*
"hi StatusLine gui=bold
