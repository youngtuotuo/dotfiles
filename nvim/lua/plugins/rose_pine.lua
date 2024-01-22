return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = true,
  opts = {
    variant = "auto", -- auto, main, moon, or dawn
    styles = {
      italic = false,
      transparency = true,
    },
    highlight_groups = {
      -- StatusLine = { fg = "iris", bg = "iris", blend = 10 },
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    },
  },
}
