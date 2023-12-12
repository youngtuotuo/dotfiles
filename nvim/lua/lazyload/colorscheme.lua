local transparent = "none"
local fg = "#c8d3f5"
local fg_dark = "#828bb8"
vim.api.nvim_set_hl(0, "Normal", { bg = transparent })
vim.api.nvim_set_hl(0, "Error", { fg = transparent })
vim.api.nvim_set_hl(0, "Pmenu", { bg = transparent })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = transparent })
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = fg })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fg_dark })
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = "NvimLightGreen", bg = transparent })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "NvimLightBlue", bg = transparent })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "NvimLightCyan", bg = transparent })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "NvimLightYellow", bg = transparent })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "NvimLightRed", bg = transparent })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "VertSplit", { link = "SignColumn" })
