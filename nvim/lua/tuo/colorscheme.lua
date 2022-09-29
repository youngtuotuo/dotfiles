local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

return {
  transparent_background = false,
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
