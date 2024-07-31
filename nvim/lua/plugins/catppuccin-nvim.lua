return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    no_italic = true,
    transparent_background = true,
    integrations = {
      treesitter = false
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
