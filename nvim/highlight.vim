" hi Normal ctermbg=000 guibg=#000000
" hi StatusLine cterm=reverse gui=reverse
hi LineNrAbove guifg=grey
hi LineNrBelow guifg=grey
hi SignColumn guibg=NONE
hi IndentBlanklineChar guifg=grey
hi EndOfBuffer guifg=grey
hi NonText guifg=grey
hi Pmenu  guibg=grey
exec 'hi FloatBorder ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui') . ' ctermbg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'cterm')
exec 'hi Pmenu '       . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui') . ' ctermbg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'cterm')
