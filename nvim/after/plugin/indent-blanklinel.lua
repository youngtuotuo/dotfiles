vim.cmd [[
  hi IndentBlanklineContextStart cterm=nocombine gui=nocombine
  hi IndentBlanklineContextChar guifg=LightGrey
]]
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_first_indent_level = false,
    enabled = false,
    show_end_of_line = true
}
