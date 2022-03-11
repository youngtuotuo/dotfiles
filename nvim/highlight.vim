" hi Normal ctermbg=000 guibg=#000000
" hi StatusLine gui=bold
hi Pmenu guibg=Black
exec 'hi FloatBorder ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')
exec 'hi Pmenu '       . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')

