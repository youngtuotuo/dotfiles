return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    show_end_of_buffer = true,
    term_colors = false,
    dim_inactive = { enabled = false },
    no_italic = false,
    no_bold = false,
    no_underline = true,
    default_integrations = false,
    integrations = {
      telescope ={
        enabled = true,
      },
      harpoon = true,
      gitsigns = true,
      treesitter = true,
      aerial = true,
      illuminate = {
        enabled = true,
        lsp = false,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colo([[catppuccin]])
  end,
}
