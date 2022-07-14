if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorizer").setup()

require("indent_blankline").setup {
  show_end_of_line = true,
}

vim.g.material_style = "deep ocean"
require("material").setup {
  contrast = {
    floating_windows = true
  },
  high_visibility = {
    darker = true
  },
  disable = {
    background = false
  },
  lualine_style = "stealth",
  custom_highlights = {
    Normal = { bg = 'NONE' },
    NormalNC = { bg = 'NONE' },
    WinSeparator = { fg = '#DDDCD7' }
  }
}
vim.cmd 'colo material'
require('lualine').setup {
  options = {
    icons_enabled = false
  }
}
-- require("colorbuddy").colorscheme "gruvbuddy"
-- local c = require("colorbuddy.color").colors
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles

-- Group.new("GoTestSuccess", c.green, nil, s.bold)
-- Group.new("GoTestFail", c.red, nil, s.bold)
--
-- Group.new('Keyword', c.purple, nil, nil)
--
-- Group.new("TSPunctBracket", c.orange:light():light())
--
-- Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
-- Group.new("StatuslineError2", c.red:light(), g.Statusline)
-- Group.new("StatuslineError3", c.red, g.Statusline)
-- Group.new("StatuslineError3", c.red:dark(), g.Statusline)
-- Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)
--
-- Group.new("pythonTSType", c.red)
-- Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
--
-- Group.new("typescriptTSConstructor", g.pythonTSType)
-- Group.new("typescriptTSProperty", c.blue)
--
-- Group.new("WinSeparator", nil, nil)
-- Group.new("TSTitle", c.blue)
