return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "frappe",
    no_italic = true,
    transparent_background = false,
    integrations = {
      treesitter = true,
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = {}, -- Change the style of comments
      conditionals = { "bold" },
      loops = { "bold" },
      functions = { "bold" },
      keywords = { "bold" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = { "bold" },
      properties = {},
      types = { "bold" },
      operators = {},
    },
    custom_highlights = function(colors)
      return {
        StatusLine = { fg = colors.text, bg = colors.crust },
        StatusLineNC = { fg = colors.overlay0, bg = colors.crust },
        NormalFloat = { fg = colors.text, bg = "NONE" },
        VertSplit = { fg = colors.text },
        WinSeparator = { fg = colors.text }
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
