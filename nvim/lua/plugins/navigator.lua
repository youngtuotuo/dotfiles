return {
  "numToStr/Navigator.nvim",
  config = function()
    require("Navigator").setup()
    vim.keymap.set({ "n", "t" }, "<C-w>h", "<CMD>NavigatorLeft<CR>")
    vim.keymap.set({ "n", "t" }, "<C-w>l", "<CMD>NavigatorRight<CR>")
    vim.keymap.set({ "n", "t" }, "<C-w>k", "<CMD>NavigatorUp<CR>")
    vim.keymap.set({ "n", "t" }, "<C-w>j", "<CMD>NavigatorDown<CR>")
    vim.keymap.set({ "n", "t" }, "<C-w>p", "<CMD>NavigatorPrevious<CR>")
  end,
}
