lua << EOF
--vim.opt.termguicolors = true
--vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineContextStart guisp=NONE gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#455574 gui=nocombine]]
vim.opt.list = true
-- to enable for specific buffer
-- :lua vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↵")
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
require("indent_blankline").setup {
    char = "",
    enabled = true,
    show_end_of_line = true,
    filetype = {'python'},
    filetype_exclude = {'txt', 'vim', 'yaml', 'xml', 'help'},
    buftype_exclude = {'terminal', 'nofile'},
    show_current_context = true,
    show_current_context_start = false,
    show_first_indent_level = true,
    space_char_blankline = " ",
    show_trailing_blankline_indent = false,
    context_char = "│",
    context_patterns = {'class', 'function', 'method', '^if', '^elif', '^try', '^for', '^while', '^else'},
    use_treesitter = true,
    indent_level = 10,
    --char_highlight_list = {
    --    "IndentBlanklineIndent1",
    --    "IndentBlanklineIndent2",
    --    "IndentBlanklineIndent3",
    --    "IndentBlanklineIndent4",
    --    "IndentBlanklineIndent5",
    --    "IndentBlanklineIndent6",
    --},
}
EOF
nnoremap <leader>t :IndentBlanklineToggle<CR>
