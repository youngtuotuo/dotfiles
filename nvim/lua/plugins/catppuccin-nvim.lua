return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    no_italic = true,
    transparent_background = true,
    tyles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = {},
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
    integrations = {
      treesitter = false
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
