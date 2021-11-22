" hi Normal guibg=NONE
" hi Signcolumn guibg=NONE
" hi CursorLine guibg=NONE gui=NONE
" hi link AfterIcon StatusLine
" exec 'hi AfterIcon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui') .
"             \' guifg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
" hi link AfterNIcon StatusLineNC
" exec 'hi AfterNIcon ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLineNC')), 'bg', 'gui') .
"             \' guifg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
exec 'hi DevIconGitLogo ' . ' guibg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui')
hi User1 gui=standout
hi User2 guifg=StatusLine guibg=Normal
hi link VertSplit StatusLine
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi LspReferenceText guibg=NONE gui=standout
hi LspReferenceRead guibg=NONE gui=standout
hi LspReferenceWrite guibg=NONE gui=standout
hi DiagnosticError guifg=#db4b4b
hi DiagnosticWarn  guifg=#e0af68
hi DiagnosticInfo  guifg=#0db9d7
hi DiagnosticHint  guifg=#10B981
hi DiagnosticFloatingError guifg=#db4b4b
hi DiagnosticFloatingWarn  guifg=#e0af68
hi DiagnosticFloatingInfo  guifg=#0db9d7
hi DiagnosticFloatingHint  guifg=#10B981   
hi DiagnosticUnderlineError  guifg=#db4b4b "guisp=#db4b4b gui=undercurl
hi DiagnosticUnderlineWarn   guifg=#e0af68 "guisp=#e0af68 gui=undercurl
hi DiagnosticUnderlineInfo   guifg=#0db9d7 "guisp=#0db9d7 gui=undercurl
hi DiagnosticUnderlineHint   guifg=#10B981 "guisp=#10B981 gui=undercurl
hi DiagnosticVirtualTextError guifg=#db4b4b gui=bold
hi DiagnosticVirtualTextWarn  guifg=#e0af68 gui=bold
hi DiagnosticVirtualTextInfo  guifg=#0db9d7 gui=bold
hi DiagnosticVirtualTextHint  guifg=#10B981 gui=bold
hi GitSignsAdd    gui=bold
hi GitSignsChange gui=bold
hi GitSignsDelete gui=bold
hi GitSignsChange gui=bold
" hi DiagnosticSignError guifg=#db4b4b
" hi DiagnosticSignWarn guifg=#e0af68
" hi DiagnosticSignInfo guifg=#0db9d7
" hi DiagnosticSignHint guifg=#10B981
" hi TabLineSel guibg=NONE
" hi TabLine guibg=NONE
" hi tablinefill gui=standout
" hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
" hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
" hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
" hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
" hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
" hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
" hi IndentBlanklineContextStart guisp=NONE gui=nocombine
" hi IndentBlanklineContextChar guifg=#455574 gui=nocombine
" hi NormalFloat guifg=NONE guibg=#1b212d
" hi FloatBorder guifg=NONE guibg=#1b212d
