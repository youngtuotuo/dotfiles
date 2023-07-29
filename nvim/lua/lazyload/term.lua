require("term").setup({
  shell = vim.o.shell,
  width = 0.95,
  height = 0.95,
  anchor = "N",
  position = "center",
  title_align = "center",
  border = {
    chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    hl = "TermBorder",
  },
})
