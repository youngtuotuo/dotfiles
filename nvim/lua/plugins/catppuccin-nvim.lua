return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    no_italic = true,
    transparent_background = true,
    integrations = {
      treesitter = false
    },
    custom_highlights = function(colors)
      return {
        StatusLine = { fg = colors.text, bg = colors.base },
        StatusLineNC = { fg = colors.overlay0, bg = colors.base }
      }
    end
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
