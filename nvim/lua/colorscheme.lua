vim.opt.termguicolors = true

require("colorizer").setup()

require("indent_blankline").setup {
  enabled = false,
  show_end_of_line = true,
}

require("nvim-web-devicons").setup {
  default = true;
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false

vim.cmd[[colorscheme tokyonight]]
