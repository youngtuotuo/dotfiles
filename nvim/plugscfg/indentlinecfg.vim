lua << EOF
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    char = "│",
    enabled = true,
    use_treesitter = true,
    show_end_of_line = true,
    filetype = {'python', 'yaml', 'xml'},
    filetype_exclude = {'txt', 'vim', 'help'},
    buftype_exclude = {'terminal', 'nofile'},
    show_first_indent_level = false,
    space_char_blankline = " ",
    show_trailing_blankline_indent = true,
}
EOF
