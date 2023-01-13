vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", {nocombine=true})
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {fg="LightGrey"})

require("indent_blankline").setup {
    enabled = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_first_indent_level = true,
    show_end_of_line = true
}
