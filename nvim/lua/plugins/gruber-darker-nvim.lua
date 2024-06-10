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
  end
}
