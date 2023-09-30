require("ibl").setup({
  enabled = false,
})
vim.keymap.set("n", "<leader>i", ":IBLToggle<cr>")
