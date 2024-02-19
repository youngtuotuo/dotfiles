return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "auto", -- auto, main, moon, or dawn
    enable = {
      terminal = false
    },
    styles = {
      italic = false,
      transparency = true,
    },
    highlight_groups = {
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd [[colo rose-pine]]
  end
}
