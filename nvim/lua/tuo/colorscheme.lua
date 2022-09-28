local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  transparent_background = false,
  term_colors = false,
  compile = {
      enabled = false,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
  },
  styles = {
      comments = { "italic" },
      conditionals = { "bold" },
      loops = {},
      functions = { "bold" },
      keywords = { "bold" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = { "bold" },
      properties = {},
      types = {},
      operators = {},
  },
  integrations = {
      -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
  },
  color_overrides = {},
  highlight_overrides = {},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
