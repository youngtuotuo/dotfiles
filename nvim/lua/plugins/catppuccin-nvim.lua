return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    styles = {
      comments = {},
      conditionals = {}
    },
    no_underline = true,
    integrations = {
      aerial = true,
      alpha = false,
      cmp = true,
      dashboard = false,
      flash = false,
      gitsigns = true,
      harpoon = true,
      indent_blankline = false,
      nvimtree = false,
      ufo = false,
      rainbow_delimiters = false,
      illuminate = false,
      semantic_tokens = false,
      neogit = false,
      treesitter = false,
      notify = false,
      mini = false,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colo "catppuccin"
  end
}
