return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    transparent_background = true,
    show_end_of_buffer = true,
    term_colors = false,
    dim_inactive = { enabled = false },
    no_italic = false,
    no_bold = true,
    no_underline = true,
    default_integrations = false,
    integrations = {
      aerial = true,
      illuminate = {
        enabled = true,
        lsp = false,
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    -- vim.cmd.colo([[catppuccin]])
  end,
}
