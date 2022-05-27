lua << EOF
  require("stabilize").setup()
EOF
colorscheme default
hi VertSplit ctermfg=White ctermbg=NONE guifg=White guibg=NONE
hi Comment ctermfg=Green cterm=NONE guifg=Green gui=NONE
hi NormalFloat ctermbg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE guibg=NONE
hi ModeMsg ctermfg=White ctermbg=NONE cterm=bold guifg=White guibg=NONE gui=bold
hi DiagnosticHint ctermfg=LightYellow guifg=LightYellow
hi Search cterm=reverse gui=reverse
hi Pmenu ctermfg=White ctermbg=NONE guifg=White guibg=NONE 
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=NONE
