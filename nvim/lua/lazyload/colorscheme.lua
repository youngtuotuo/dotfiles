require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = {}, -- Change the style of comments
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
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = false,
      indentscope_color = "",
    },
    indent_blankline = {
      enabled = true,
      scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

vim.cmd.colorscheme("catppuccin")

local transparent = "none"
local fg = "#c8d3f5"
local fg_dark = "#828bb8"
local border_fg = "#589ed7"
vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = transparent })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_fg, bg = transparent })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = transparent })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fg_dark, bg = transparent })
vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "FloatBorder" })
