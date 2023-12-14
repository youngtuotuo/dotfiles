local transparent = "none"
local function basic_hl()
  -- vim.api.nvim_set_hl(0, "Normal", { bg = transparent })
  -- vim.api.nvim_set_hl(0, "NormalNC", { bg = transparent })
  vim.api.nvim_set_hl(0, "Error", { fg = transparent })

  vim.api.nvim_set_hl(0, "LspReferenceRead", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { reverse = true })
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = "NvimLightGreen", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "NvimLightBlue", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "NvimLightCyan", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "NvimLightYellow", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "NvimLightRed", bg = transparent })

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = transparent })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "NormalFloat" })
end
basic_hl()

vim.api.nvim_create_autocmd("ColorScheme", { callback = basic_hl })
