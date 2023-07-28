require("term").setup({
    shell = vim.o.shell,
    width = 0.9,
    height = 0.8,
    anchor = "NW",
    position = "center",
    title = {
        align = "center", -- left, center or right
    },
    border = {
        chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        hl = "TermBorder",
    },
})
