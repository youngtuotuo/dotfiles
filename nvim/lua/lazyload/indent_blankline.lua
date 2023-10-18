require("ibl").setup({
  enabled = false,
  scope = { enabled = true, show_start = false },
  indent = { char = '│' },
})
vim.keymap.set("n", "<leader>i", "<cmd>IBLToggle<cr>")
