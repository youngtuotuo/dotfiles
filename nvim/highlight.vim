" hi Normal guibg=#282c34
" hi NormalFloat guibg=#455574
" hi FloatBorder guibg=#455574
" hi StatusLine gui=bold
" hi NonText guifg=White
" exec 'hi FloatBorder ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')
" exec 'hi Pmenu ' . ' guibg=' . synIDattr(synIDtrans(hlID('NormalFloat')), 'bg', 'gui')
hi LspReferenceText guibg=NONE gui=standout
hi LspReferenceRead guibg=NONE gui=standout
hi LspReferenceWrite guibg=NONE gui=standout

hi DiagnosticUnderlineError gui=NONE
hi DiagnosticUnderlineWarn  gui=NONE
hi DiagnosticUnderlineInfo  gui=NONE
hi DiagnosticUnderlineHint  gui=NONE

exec 'hi DiagnosticUnderlineError  ' . ' guifg=' . synIDattr(synIDtrans(hlID('DiagnosticError')), 'fg', 'gui')
exec 'hi DiagnosticUnderlineWarn   ' . ' guifg=' . synIDattr(synIDtrans(hlID('DiagnosticWarn')), 'fg', 'gui')
exec 'hi DiagnosticUnderlineInfo   ' . ' guifg=' . synIDattr(synIDtrans(hlID('DiagnosticInfo')), 'fg', 'gui')
exec 'hi DiagnosticUnderlineHint   ' . ' guifg=' . synIDattr(synIDtrans(hlID('DiagnosticHint')), 'fg', 'gui')
