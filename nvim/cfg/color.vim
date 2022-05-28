lua << EOF
  require("stabilize").setup()
EOF
colorscheme desert
hi VertSplit ctermfg=White ctermbg=NONE cterm=NONE guifg=White guibg=NONE gui=NONE
hi Comment ctermfg=Gray cterm=NONE guifg=Gray gui=NONE
hi NormalFloat ctermbg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE guibg=NONE
hi ModeMsg ctermfg=White ctermbg=NONE cterm=bold guifg=White guibg=NONE gui=bold
hi DiagnosticHint ctermfg=LightYellow guifg=LightYellow
hi Search cterm=reverse gui=reverse
hi Visual ctermbg=DarkGray cterm=NONE guibg=DarkGray gui=NONE
hi Pmenu ctermfg=White ctermbg=NONE guifg=White guibg=NONE 
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
