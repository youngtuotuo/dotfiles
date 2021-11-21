augroup StHighlight
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setl statusline=%{%LocalActivestatus()%}
  autocmd WinLeave * setl statusline=%{%LocalNActivestatus()%}
augroup END

function! MyFileformat() abort
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) . ' ' . &fileformat: ''
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
   elseif ft == "vim"
      return WebDevIconsGetFileTypeSymbol() .. " vimls"
   elseif ft == "bash"
      return WebDevIconsGetFileTypeSymbol() .. " bashls"
  elseif ft == "yaml"
      return WebDevIconsGetFileTypeSymbol() .. " yamlls"
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

function! Git()
   let branch = FugitiveHead()
   let icon = luaeval("require'nvim-web-devicons'.get_icon('.git','git',{ default = true })")
   let gitstatus = strlen(branch) ? icon .. ' ' .. branch ..  ' ' .. get(b:,'gitsigns_status',''): ""
   return gitstatus
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

function! LocalActivestatus()
    let s = ''
    " let mode = ' ' .. toupper(g:currentmode[mode()]) .. ' '
    " let env = ' ' .. Env() .. ' '
    " let gitstatus = Git()
    " let gitfinal = repeat(' ', float2nr((nvim_win_get_width(0) - strlen(gitstatus))/2 - strlen(expand('%t')))) .. gitstatus
    let format = ' ' .. MyFileformat() .. ' '

    let s .= '%1*'
    let s .= ' %t%h%w%m%r '
    " let s .= mode
    let s .= '%#StatusLine#'
    " let s .= env
    " let s .= gitfinal
    let s .= '%='
    let s .= format
    let s .= '%1*'
    let s .= ' %l,%c%V %P ' 
    return s
endfunction

function! LocalNActivestatus()
    let s = ''
    let format = ' ' .. MyFileformat() .. ' '
    " let gitstatus = Git()
    " let gitfinal = repeat(' ', float2nr((nvim_win_get_width(0) - strlen(gitstatus))/2 - strlen(expand('%t')))) .. gitstatus

    let s.= '%#StatusLineNC#'
    let s.= ' %t%h%w%m%r '
    " let s.= gitfinal
    let s.= '%='
    let s.= format
    let s.= ' %l,%c%V %P '
    return s
endfunction
