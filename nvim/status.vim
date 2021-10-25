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
       return bytes . " B"
   else
       return (bytes / 1024) . " KB"
   endif
endfunction

function! Server()
   let ft = &filetype
   if ft == "python"
      return "Pyright"
   endif
   if ft == "vim"
      return "Vimls"
   endif
   if ft == "bash"
      return "bashls"
   endif
   if ft == "yaml"
      return "yamlls"
   endif
endfunction

function! Version()
   return 'NVIM-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*')
endfunction

function! Lspinfo()
   let server = Server()
   if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
      if luaeval("vim.lsp.buf.server_ready()")
         return "‹‹ " .. server .. " ready ››" 
      else
         return "‹‹ " .. serevr .. " not ready ››"
      endif
   else
      return "‹‹ No lsp ››"
   endif
endfunction

function! Git()
   let branch = FugitiveHead()
   return strlen(branch) ? branch=='master' ? "[ " .. branch .. "]" : "[ " .. branch .. "]" : "[∅ git]"
endfunction

set statusline=%1*
set statusline+=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
" set statusline+=%#PmenuSel#
" set statusline+=[%n]
" set statusline+=
" set statusline+=\ [
" set statusline+=%{%FileSize()%}
" set statusline+=]
" set statusline+=\ %{%Git()%}
" set statusline+=\ ‹‹
" set statusline+=%2*
" set statusline+=\ %{%WebDevIconsGetFileTypeSymbol()%}
" set statusline+=%1*
" set statusline+=\ %t
" set statusline+=\ ››
" set statusline+=\ -
" set statusline+=\ (%l/%L)
" set statusline+=\ %r%h%w%q%m
" set statusline+=%=
" set statusline+=\ %{%Lspinfo()%}
" set statusline+=\  
" set statusline+=\ %{%Version()%}
" set statusline+=\ %{%MyFiletype()%}
" set statusline+=%1*
