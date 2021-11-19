func! NvimGps() abort
    return luaeval("require'nvim-gps'.is_available()") ?
    \ ' ' .. luaeval("require'nvim-gps'.get_location()") : ''
endf

function! Version()
   return 'NVIM-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*') .. ' '
endfunction

set showtabline=2
" set tabline=%!Tabline()
set tabline=
set tabline+=%#tablinefill#\ %F\ %{%WebDevIconsGetFileTypeSymbol()%}\ %{NvimGps()}\ %#StatusLine#%=%#tablinefill#\ %{%Version()%}
augroup THighlight
  autocmd!
  autocmd CursorMoved,CursorMovedI * set tabline=%#tablinefill#\ %F\ %{%WebDevIconsGetFileTypeSymbol()%}\ %{NvimGps()}\ %#StatusLine#%=%#tablinefill#\ %{%Version()%}
augroup END
hi TabLineSel guibg=NONE
hi TabLine guibg=NONE
" hi tablinefill gui=NONE guibg=NONE guifg=#e1e3e4
hi tablinefill guifg=#e1e3e4 guibg=NONE gui=standout

" function! Tabline()
"   let s = ''
"   for i in range(tabpagenr('$'))
"     let tab = i + 1
"     let winnr = tabpagewinnr(tab)
"     let buflist = tabpagebuflist(tab)
"     let bufnr = buflist[winnr - 1]
"     let bufname = bufname(bufnr)
"     let bufmodified = getbufvar(bufnr, "&mod")

"     let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
"     let s .= '%' . tab . 'T'
"     let s .= ' ' . tab . ' '
"     let s .= (bufname != '' ? fnamemodify(bufname, ':t') . ' ' : 'No Name ')

"     if bufmodified
"       let s .= '[+] '
"     endif
"   endfor

"   let s .= '%#TabLineFill#'
"   if (exists("g:tablineclosebutton"))
"     let s .= '%=%999XX'
"   endif
"   return s
" endfunction
