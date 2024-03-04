return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "moon", -- auto, main, moon, or dawn
    enable = {
      terminal = false
    },
    styles = {
      bold = true,
      italic = false,
      transparency = true,
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
  end
}
