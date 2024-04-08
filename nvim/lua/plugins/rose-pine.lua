return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    enable = {
      terminal = false,
    },
    styles = {
      bold = false,
      italic = false,
    },
    highlight_groups = {
      TelescopeBorder = { fg = "highlight_high", bg = "none" },
      TelescopeNormal = { bg = "none" },
      TelescopePromptNormal = { bg = "base" },
      TelescopeResultsNormal = { fg = "subtle", bg = "none" },
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { bg = "rose" },
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd.colo([[rose-pine]])
    _G.colorset()
  end,
}
