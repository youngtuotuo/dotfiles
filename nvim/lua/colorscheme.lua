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
    theme = 'github_dark_default',
  },
  sections = {
    lualine_a = {
      { 'mode', right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', left_padding = 2 },
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
-- vim.cmd [[
--         colo lunaperche
-- ]]
require('github-theme').setup({
  theme_style='dark_default' -- dark/dimmed/dark_default/dark_colorblind/light/light_default/light_colorblind
})
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "-", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
require("workspaces").setup({
  hooks = {
    open = "NvimTreeOpen .",
  }
})
