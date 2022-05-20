lua << EOF
  require('colorizer').setup()
  require('colorbuddy').colorscheme('gruvbuddy')
  require("stabilize").setup()
EOF
hi LineNr      guifg=yellow  
hi LineNrAbove guifg=DarkGray
hi LineNrBelow guifg=DarkGray
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
" hi StatusLine guibg=white guifg=black
" hi StatusLineNC guibg=white guifg=black
" hi Pmenu guibg=grey
" hi PmenuSel guibg=dark
