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
      aerial = true
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colo [[catppuccin]]
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkRed" })
    vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Search" })
    vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Search" })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "Search" })
  end
}
