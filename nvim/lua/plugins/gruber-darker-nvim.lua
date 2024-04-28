return {
  "blazkowolf/gruber-darker.nvim",
  opts = {
    italic = {
      strings = false,
      comments = true,
      folds = false
    },
  },
  config = function(_, opts)
    require("gruber-darker").setup(opts)
    vim.cmd.colo "gruber-darker"
    _G.colorset()
    -- vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#cccccc" })
    -- vim.api.nvim_set_hl(0, "Comment", { fg = "DarkGrey", italic = true })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  end
}
