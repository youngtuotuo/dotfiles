set showtabline=2

augroup THighlight
  autocmd!
  autocmd CursorMoved,CursorMovedI * set tabline=%{%TabLine()%}
augroup END

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
   return 'NVIM-' .. matchstr(execute('version'), 'NVIM v\zs[^\n]*') .. ' '
endfunction

function! Icon()
    let ft = ''
    let filetype = &filetype

    if filetype == ''
        return ''
    else
        if filetype == "python"
            let ft = 'py'
        elseif filetype == "NvimTree"
            let ft = 'vim'
        elseif filetype == "help"
            let ft = 'txt'
        else
            let ft = filetype
        endif
        let cmd = "require'nvim-web-devicons'.get_icon('" .. expand('%:t').. "','" .. ft .. "',{ default = true })"
        return luaeval(cmd)
    endif
endfunction

function! Git()
   let branch = FugitiveHead()
   let icon = luaeval("require'nvim-web-devicons'.get_icon('.git','git',{ default = true })")
   let gitstatus = strlen(branch) ? icon .. ' ' .. branch ..  ' ' .. get(b:,'gitsigns_status',''): ""
   return gitstatus
endfunction


function! TabLine()
    let gps = NvimGps()
    let git = ' ' .. Git() .. ' '
    let gpsfinal = repeat(' ', float2nr((&columns - strlen(gps))/2 - strlen(git))) .. gps
    let s = ''
    let s .= '%#StatusLine#'
    let s .= git
    " let s .= Icon()
    " let s .= fname
    " let s .= ' ' .. expand('%:h')
    " let s .= ' ' .. expand('%:~:h')
    " let s .= ' t%h%w%m%r'
    let s .= '%2*'
    let s .= gpsfinal .. ' '
    let s .= '%='
    let s .= '%#StatusLine#'
    let s .= ' ' .. Version()
    return s
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
