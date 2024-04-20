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
  end
}
