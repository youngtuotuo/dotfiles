vim.opt.termguicolors = true

require("colorizer").setup()

require("indent_blankline").setup {enabled = false, show_end_of_line = true}

require("nvim-web-devicons").setup {default = true}

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {list = {{key = "-", action = "dir_up"}}}
  },
  renderer = {group_empty = true},
  filters = {dotfiles = true}
})

require("workspaces").setup({hooks = {open = "NvimTreeOpen ."}})

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd [[colorscheme catppuccin]]

