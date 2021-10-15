lua << EOF
--vim.opt.termguicolors = true
--vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = false
-- to enable for specific buffer
-- :lua vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↵")
require("indent_blankline").setup {
    enabled = true,
    show_end_of_line = true,
    filetype = {'py'},
    filetype_exclude = {'txt', 'vim', 'yaml', 'xml', 'help'},
    buftype_exclude = {'terminal'},
    --show_current_context = true,
    show_first_indent_level = false,
    space_char_blankline = " ",
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
