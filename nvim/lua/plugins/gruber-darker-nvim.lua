return {
  "blazkowolf/gruber-darker.nvim",
  lazy = true,
  opts = {
    italic = {
      strings = false,
      comments = true,
      folds = false
    },
  },
  config = function(_, opts)
    require("gruber-darker").setup(opts)
    -- vim.cmd.colo "gruber-darker"
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}
