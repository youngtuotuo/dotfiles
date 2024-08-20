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
      strings = false,
      comments = false,
      operators = false,
      folds = false,
    },
    undercurl = true,
    underline = false,
  },
  config = function(_, opts)
    require("gruber-darker").setup(opts)
    vim.cmd.colo("gruber-darker")
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#292929" })
  end,
}
