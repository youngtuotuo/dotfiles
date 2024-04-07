return {
  "rose-pine/neovim", name="rose-pine",
  opts = {
    enable = {
      terminal = false
    },
    styles = {
      bold = false,
      italic = false,
    }
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd.colo [[rose-pine]]
  end
}
