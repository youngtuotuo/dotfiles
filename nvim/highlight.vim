hi Normal guibg=#000000
hi StatusLine gui=bold
exec 'hi FloatBorder ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')
exec 'hi Pmenu '       . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')

