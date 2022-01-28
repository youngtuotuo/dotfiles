set showtabline=2

augroup THighlight
  autocmd!
  autocmd CursorMoved,CursorMovedI * set tabline=%{%TabLine()%}
augroup END

function! TabLine()
    let time = "%{strftime('%a\ %b %d\ %H:%M')}"
    let gps = ' ' .. NvimGps() .. ' '
    " let git = ' ' .. Git() .. ' '
    let empty = repeat(' ', float2nr((&columns - strlen(gps))/2))

    let s = ''
    " let s .= '%#StatusLine#'
    let s .= '%#Normal#'
    " if strlen(git)!=2
    "     let s .= git
    " endif
    " let s .= '%#Normal#'
    let s .= empty
    " let s .= '%#TabLine#'
    if strlen(gps)!=2
        let s .= gps
    endif
    " let s .= '%#Normal#'
    " let s .= '%#Normal#'
    let s .= '%='
    let s .= time
    " let s .= '%#StatusLine#'
    " let s .= ' ' .. Version()
    return s
endfunction

func! NvimGps()
    if luaeval("require'nvim-gps'.is_available()")
        if luaeval("require'nvim-gps'.get_location()") == ''
            return ''
        else
            return luaeval("require'nvim-gps'.get_location()")
        endif
    else
        return ''
    endif
endf

function! Version()
   return 'neovim-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*') .. ' '
endfunction

function! Git()
   let branch = FugitiveHead()
   " let icon = luaeval("require'nvim-web-devicons'.get_icon('.git','git',{ default = true })")
   " let gitstatus = strlen(branch) ? '%#DevIconGitLogo#' .. icon .. ' %#StatusLine#' .. branch ..  ' ' .. get(b:,'gitsigns_status',''): ''
   let gitstatus = strlen(branch) ? ' %#StatusLine#' .. branch ..  ' ' .. get(b:,'gitsigns_status',''): ''
   return gitstatus
endfunction

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
