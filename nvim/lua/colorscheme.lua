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
    theme = 'tokyonight'
  }
}

vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false

vim.cmd[[colorscheme tokyonight]]
