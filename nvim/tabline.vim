func! NvimGps() abort
    if luaeval("require'nvim-gps'.is_available()")
        if luaeval("require'nvim-gps'.get_location()") == ''
            return ''
        else
            return "/" ..  luaeval("require'nvim-gps'.get_location()")
        endif
    else
        return ''
    endif
endf

function! Version()
   return 'NVIM-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*') .. ' '
endfunction

function! Icon()
    let ft = ''
    if &filetype == "python"
        let ft = 'py'
    elseif &filetype == "NvimTree"
        let ft = 'vim'
    elseif &filetype == "help"
        let ft = 'txt'
    else
        let ft = &filetype
    endif
    let cmd = "require'nvim-web-devicons'.get_icon('" .. expand('%:t').. "','" .. ft .. "',{ default = true })"
    return luaeval(cmd)
endfunction

function! TabLine()
    let s = ''
    let s .= ' ' .. expand('%:h')
    " let s .= ' ' .. expand('%:~:h')
    let s .= '/' .. Icon()
    let s .= ' %t%h%w%m%r'
    let s .= NvimGps()
    let s .= '%='
    let s .= ' ' .. Version()
    return s
endfunction

set showtabline=2

augroup THighlight
  autocmd!
  autocmd CursorMoved,CursorMovedI * set tabline=%{%TabLine()%}
augroup END

" hi TabLineSel guibg=NONE
" hi TabLine guibg=NONE
hi tablinefill gui=standout

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
"
