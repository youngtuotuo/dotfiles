lua << EOF
  require("stabilize").setup()
EOF
" hi LineNr      guifg=yellow  
" hi LineNrAbove guifg=Gray
" hi LineNrBelow guifg=Gray
" hi NormalFloat guibg=#282c34
hi VertSplit cterm=reverse ctermfg=NONE ctermbg=NONE
hi NormalFloat cterm=NONE ctermbg=DarkGray
hi FloatBorder cterm=NONE ctermbg=DarkGray
" hi Type gui=NONE
hi StatusLine cterm=NONE ctermfg=LightGray ctermbg=NONE guifg=LightGray guibg=NONE
hi StatusLineNC cterm=NONE ctermfg=White ctermbg=NONE guibg=white guifg=black
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
hi Pmenu cterm=NONE ctermfg=Black ctermbg=DarkGray
hi PmenuSel ctermfg=Black ctermbg=Gray guifg=Black guibg=DarkGray
