augroup StHighlight
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setl statusline=%{%LocalActivestatus()%}
  autocmd VimEnter,WinEnter,BufWinEnter * setl cursorline
  autocmd WinLeave * setl statusline=%{%LocalNActivestatus()%}
  autocmd WinLeave * setl nocursorline
augroup END

function! LocalActivestatus()
    let mode = ' ' .. toupper(g:currentmode[mode()]) .. ' '

    let s = ''
    " let s .= '%1*'
    " if &filetype != "NvimTree"
    "     let s .= mode
    " endif
    " let s .= '%#StatusLine#'
    " let s .= ' %#Icon#%{%Icon()%}'
    let s .= ' %#StatusLine#%t%h%w%m%r* '
    " let s .= '%#Normal#'
    " let s .= '%#StatusLine#'
    let s .= '%='
    let s .= ' %l:%c%V %P ' 
    return s
endfunction

function! LocalNActivestatus()
    let s = ''
    " let s .= '%#StatusLine#'
    " let s .= ' %#Icon#%{%Icon()%}'
    let s .= ' %#StatusLine#%t%h%w%m%r '
    " let s .= '%#Normal#'
    let s .= '%='
    " let s .= '%#StatusLine#'
    let s .= ' %l:%c%V %P '
    return s
endfunction

function! MyFileformat() abort
  return (WebDevIconsGetFileFormatSymbol()) . ' ' . &fileformat
endfunction

function! Server()
   let ft = &filetype
   if ft == "python"
      return Icon() .. " pyright"
   elseif ft == "vim"
      return Icon() .. " vimls"
   elseif ft == "bash"
      return Icon() .. " bashls"
  elseif ft == "yaml"
      return Icon() .. " yamlls"
   endif
endfunction

function! Icon()
    let ft = ''
    let filetype = &filetype

    if filetype == ''
        if &buftype == 'terminal'
            hi link Icon DevIconBash
            exec 'hi Icon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
                        \' guifg=' . synIDattr(synIDtrans(hlID('DevIconBash')), 'fg', 'gui')
            let cmd = "require'nvim-web-devicons'.get_icon('" .. expand('%:t').. "','" .. ft .. "',{ default = true })"
            return luaeval(cmd)
        else
            return ''
        endif
    else
        if filetype == "python"
            let ft = 'py'
            hi link Icon DevIconPy
            exec 'hi Icon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
                        \' guifg=' . synIDattr(synIDtrans(hlID('DevIconPy')), 'fg', 'gui')
        elseif filetype == "NvimTree" || filetype == "vim" || filetype == "netrw" || filetype == "vim-plug" || filetype == "tsplayground" || filetype == "qf"
            let ft = 'vim'
            hi link Icon DevIconVim
            exec 'hi Icon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
                        \' guifg=' . synIDattr(synIDtrans(hlID('DevIconVim')), 'fg', 'gui')
        elseif filetype == "help"
            let ft = 'txt'
            hi link Icon DevIconTxt
            exec 'hi Icon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
                        \' guifg=' . synIDattr(synIDtrans(hlID('DevIconTxt')), 'fg', 'gui')
        elseif filetype == "yaml"
            let ft = filetype
            hi link Icon DevIconYaml
            exec 'hi Icon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
                        \' guifg=' . synIDattr(synIDtrans(hlID('DevIconYaml')), 'fg', 'gui')
        else
            let ft = filetype
            hi link Icon StatusLine
        endif
        let cmd = "require'nvim-web-devicons'.get_icon('" .. expand('%:t').. "','" .. ft .. "',{ default = true })"
        return luaeval(cmd)
    endif
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

function! Env()
    return $CONDA_DEFAULT_ENV
endfunction

" :h mode() to see all modes
let g:currentmode={
    \ 'n'      : 'NORMAL',
    \ 'no'     : 'N·Operator Pending',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'VLine',
    \ "\<C-V>" : 'VBlock',
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

