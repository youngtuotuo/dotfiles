local transparent = "none"
local fg = "#c8d3f5"
local fg_dark = "#828bb8"
local border_fg = fg_dark
vim.api.nvim_set_hl(0, "Normal", { bg = transparent })
vim.api.nvim_set_hl(0, "Error", { fg = transparent })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = transparent })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_fg, bg = transparent })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = transparent })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fg_dark, bg = transparent })
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "VertSplit", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "StatusLine", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "SignColumn" })
