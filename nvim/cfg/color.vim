lua << EOF
  require("stabilize").setup()
  require('nvim_comment').setup({comment_empty = false})
EOF
color default
let s:mode_map = {
      \ 'n': '', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'VISUAL LINE', "\<C-v>": 'VISUAL BLOCK',
      \ 'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL',
      \ }
function! Statusline_mode() abort
    return mode() != 'n' ? '-- ' .. get(s:mode_map, mode(), '') .. ' --' : ''
endfunction
let &statusline='%{Statusline_mode()}' " .. '%=%(%l,%c%V %=       %P%)'
" hi Normal ctermbg=NONE guibg=NONE
exec 'hi StatusLine gui=bold cterm=bold' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
            \' ctermbg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'cterm')
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui') .
            \' ctermfg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'cterm')

" hi StatusLine ctermfg=Black ctermbg=White cterm=NONE guifg=Black guibg=White gui=NONE
" hi StatusLineNC ctermfg=Black ctermbg=White cterm=NONE guifg=Black guibg=White gui=NONE
hi VertSplit ctermfg=DarkGray ctermbg=NONE cterm=NONE guifg=DarkGray guibg=NONE gui=NONE
hi DiagnosticError ctermfg=LightRed guifg=LightRed
hi Comment ctermfg=Gray cterm=NONE guifg=Gray gui=NONE
" hi String ctermfg=DarkGreen cterm=NONE guifg=Green gui=NONE
hi NormalFloat ctermbg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE guibg=NONE
hi ModeMsg ctermfg=White ctermbg=NONE cterm=bold guifg=White guibg=NONE gui=bold
hi DiagnosticHint ctermfg=LightYellow guifg=LightYellow
hi Search cterm=reverse gui=reverse
" hi Visual ctermbg=DarkGray cterm=NONE guibg=DarkGray gui=NONE
hi Pmenu ctermfg=White ctermbg=NONE guifg=White guibg=NONE 
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
