if not pcall(require, "colorbuddy") then
  return
end

vim.opt.termguicolors = true

require("colorizer").setup()

require("indent_blankline").setup {
  enabled = false,
  show_end_of_line = true,
}

require("nvim-web-devicons").setup {
  default = true;
}

-- Default options:
require('kanagawa').setup({
    undercurl = false,           -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = false},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = true,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

-- vim.g.material_style = "deep ocean"
-- require("material").setup {
--   contrast = {
--     floating_windows = true
--   },
--   high_visibility = {
--     darker = true
--   },
--   disable = {
--     background = false
--   },
--   lualine_style = "stealth",
--   custom_highlights = {
--     Normal = { bg = 'NONE' },
--     NormalNC = { bg = 'NONE' },
--     WinSeparator = { fg = '#DDDCD7' }
--   }
-- }
-- vim.cmd 'colo material'
require('lualine').setup {
  options = {
    icons_enabled = true
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
