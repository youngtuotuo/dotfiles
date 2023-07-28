require("term").setup({
    shell = vim.o.shell,
    width = 0.9,
    height = 0.8,
    anchor = "NW",
    position = "center",
    title_align = "center",
    border = {
        chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        hl = "TermBorder",
    },
})
