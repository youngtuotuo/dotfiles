vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

return {
  transparent_background = true,
  term_colors = false,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    gitsigns = true,
    notify = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
      -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
  },
  color_overrides = {},
  highlight_overrides = {},
}
