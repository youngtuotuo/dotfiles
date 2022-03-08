lua << EOF
--vim.opt.list = true
-- to enable for specific buffer
-- :lua vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↵")
--vim.g.indent_blankline_char_highlight = 'LineNr'
--vim.g.indent_blankline_show_trailing_blankline_indent = false
require("indent_blankline").setup {
    char = "│",
    --char = "",
    enabled = false,
    show_end_of_line = true,
    filetype = {'python', 'yaml', 'xml'},
    filetype_exclude = {'txt', 'vim', 'help', 'NvimTree'},
    buftype_exclude = {'terminal', 'nofile'},
    show_current_context = true,
    show_current_context_start = false,
    show_first_indent_level = true,
    space_char_blankline = " ",
    show_trailing_blankline_indent = false,
    context_char = "│",
    context_patterns = {'class', 'function', 'method', '^if', '^elif', '^try', '^for', '^while', '^else'},
    use_treesitter = false,
    indent_level = 10,
    --char_highlight_list = {
    --    "IndentBlanklineIndent1",
    --},
    --space_char_highlight_list = {
    --    "IndentBlanklineIndent1",
    --    "IndentBlanklineIndent2",
    --},
}
EOF
nnoremap <leader>t :IndentBlanklineToggle<CR>
