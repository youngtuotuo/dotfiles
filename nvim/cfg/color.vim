lua << EOF
  require("stabilize").setup()
EOF
let g:lucius_contrast = 'high'
let g:lucius_contrast_bg = 'high'
colorscheme lucius
" hi LineNr      guifg=yellow  
" hi LineNrAbove guifg=Gray
" hi LineNrBelow guifg=Gray
" hi NormalFloat guibg=#282c34
hi Normal ctermbg=Black
hi VertSplit cterm=reverse ctermfg=NONE ctermbg=NONE
hi NormalFloat cterm=NONE ctermbg=Black
hi FloatBorder cterm=NONE ctermbg=Black
hi DiagnosticError ctermfg=LightRed
" hi Type gui=NONE
" hi StatusLine cterm=NONE ctermfg=LightGray ctermbg=NONE guifg=LightGray guibg=NONE
" hi StatusLineNC cterm=NONE ctermfg=White ctermbg=NONE guibg=white guifg=black
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
hi Pmenu cterm=NONE ctermfg=White ctermbg=Black
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=DarkGray
