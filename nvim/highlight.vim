hi Normal ctermbg=NONE guibg=NONE
hi EndOfBuffer guibg=NONE
hi ModeMsg guifg=white gui=bold
hi Title guifg=white
hi LineNrAbove guifg=grey
hi LineNrBelow guifg=grey
hi SignColumn guibg=NONE
hi IndentBlanklineChar guifg=grey
hi EndOfBuffer guifg=grey
hi NonText guifg=grey
hi NormalFloat ctermbg=000 guibg=#000000
hi GitSignsAdd      guifg=LightGreen guibg=NONE
hi GitSignsChange   guifg=LightYellow guibg=NONE
hi GitSignsDelete  guifg=LightRed guibg=NONE
exec 'hi FloatBorder ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui') . ' ctermbg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'cterm')
exec 'hi Pmenu '       . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui') . ' ctermbg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'cterm')
