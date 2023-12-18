require("aerial").setup({
  layout = {
    default_direction = "left",
    max_width = 30,
    min_width = 30,
  }
})
vim.keymap.set("n", "<space>o", function()
  require("aerial").toggle({ focus = false })
end, { noremap = true, silent = true })
