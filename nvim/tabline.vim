function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    " let s .= '%' . tab . 'T'
    " let s .= ' ' . tab . ' '
    let s .= ' '
    let icon = WebDevIconsGetFileTypeSymbol(fnamemodify(bufname, ':t'))
    let icon = (tab == tabpagenr() ? '%2*' . icon . '%#TabLineSel#' : '%3*' . icon . '%#TabLine#')
    let s .= (bufname != '' ? icon . ' ' . fnamemodify(bufname, ':t') . ' ' : 'No Name ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction

set showtabline=2
set tabline=%!Tabline()
