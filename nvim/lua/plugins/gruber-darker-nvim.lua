return {
  "blazkowolf/gruber-darker.nvim",
  opts = {
    italic = {
      strings = false,
      comments = false,
      folds = false
    },
  },
  config = function(_, opts)
    require("gruber-darker").setup(opts)
    vim.cmd.colo "gruber-darker"
    _G.colorset()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  end
}
