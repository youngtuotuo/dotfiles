return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  opts = {
    width = 150,
  },
  init = function(_, opts)
    require("no-neck-pain").setup(opts)
    vim.keymap.set({ "n" }, "<space>n", ":NoNeckPain<cr>", { noremap = true })
  end
}
