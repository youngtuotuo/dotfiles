" color desert
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
" hi StatusLine guibg=lightgrey guifg=black
" hi StatusLineNC guibg=lightgrey guifg=black
" hi Pmenu guibg=grey
" hi PmenuSel guibg=dark
lua << EOF
  require('colorizer').setup()
  require('colorbuddy').colorscheme('gruvbuddy')
  -- require('onedark').setup({
  --   style = 'deep', -- dark, darker, cool, deep, warm, warmer, light
  --   highlights = {
  --     Normal              = {bg='black'},
  --     EndOfBuffer         = {fg='grey', bg='black'},
  --     SignColumn          = {bg='black'},
  --     StatusLine          = {fg='black', bg='lightgrey', fmt='none'},
  --     LineNrAbove         = {fg='grey'},
  --     LineNrBelow         = {fg='grey'},
  --     LineNr              = {fg='white'},
  --     CursorLineNr        = {fg='white'},
  --     CursorLine          = {bg='$bg0', fmt='none'},
  --     LspReferenceRead    = {bg='$bg0', fmt='standout'},
  --     LspReferenceText    = {bg='$bg0', fmt='standout'},
  --     LspReferenceWrite   = {bg='$bg0', fmt='standout'},
  --     VertSplit           = {fg='lightgrey'},
  --     DiagnosticVirtualTextWarn = {fg='$yellow', bg='none'},
  --     DiagnosticVirtualTextError = {fg='$red', bg='none'},
  --     DiagnosticVirtualTextInfo = {fg='$cyan', bg='none'},
  --     DiagnosticVirtualTextHint = {fg='$purple', bg='none'},
  --   },
  --   code_style = {
  --     comments  = 'none',
  --     keywords  = 'none',
  --     functions = 'none',
  --     strings   = 'none',
  --     variables = 'none'
  --   },
  -- })
  -- require('onedark').load()

  vim.opt.list = false
  vim.opt.listchars:append("eol:↵")
  require("indent_blankline").setup {
    enabled = false,
    show_first_indent_level = true,
    space_char_blankline = " ",
    show_current_context = false,
  }
  vim.cmd [[
    highlight IndentBlanklineContextChar guifg=lightgrey gui=nocombine
    highlight IndentBlanklineSpaceChar gui=nocombine
  ]]
  require("stabilize").setup()
EOF
