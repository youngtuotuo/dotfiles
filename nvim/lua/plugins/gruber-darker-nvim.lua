return {
  "blazkowolf/gruber-darker.nvim",
  opts = {
    bold = true,
    invert = {
      signs = false,
      tabline = false,
      visual = false,
    },
    italic = {
      strings = true,
      comments = true,
      operators = false,
      folds = true,
    },
    undercurl = true,
    underline = true,
  },
  config = function(_, opts)
    require("gruber-darker").setup(opts)
    vim.cmd.colo "gruber-darker"
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
