return {
  "lervag/vimtex",
  ft = { "tex" },
  config = function()
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_imaps_enabled = 0
    vim.keymap.set({ "i" }, "<C-x><cr>", "<plug>(vimtex-delim-close)")
  end,
}
