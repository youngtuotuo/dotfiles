-- vim.opt.list = true
-- vim.opt.listchars = "eol:⏎"
require("ibl").setup({
  enabled = false,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = false,
  show_first_indent_level = false,
  show_end_of_line = false,
  show_trailing_blankline_indent = false,
})
vim.keymap.set("n", "<leader>i", ":IBLToggle<cr>")
