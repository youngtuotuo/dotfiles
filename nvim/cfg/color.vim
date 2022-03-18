lua << EOF
  require('colorizer').setup()
  require('onedark').setup({
    highlights = {
      Normal              = {bg='black'},
      EndOfBuffer         = {fg='grey', bg='black'},
      SignColumn          = {bg='black'},
      StatusLine          = {fg='black', bg='lightgrey', fmt='bold'},
      LineNrAbove         = {fg='grey'},
      LineNrBelow         = {fg='grey'},
      LineNr              = {fg='white'},
      CursorLineNr        = {fg='white'},
      CursorLine          = {bg='none', fmt='underline'},
      LspReferenceRead    = {bg='$bg0', fmt='none'},
      LspReferenceText    = {bg='$bg0', fmt='none'},
      LspReferenceWrite   = {bg='$bg0', fmt='none'},
    },
    code_style = {
      comments  = 'none',
      keywords  = 'none',
      functions = 'none',
      strings   = 'none',
      variables = 'none'
    },
  })
  require('onedark').load()
EOF
