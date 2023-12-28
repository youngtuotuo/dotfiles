local transparent = "none"
local function basic_hl()
  -- vim.api.nvim_set_hl(0, "Normal", { bg = transparent })
  -- vim.api.nvim_set_hl(0, "NormalNC", { bg = transparent })

  vim.api.nvim_set_hl(0, "Error", { fg = transparent })
  vim.api.nvim_set_hl(0, "StatusLine", { reverse = true, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = "NvimLightYellow" })

  vim.api.nvim_set_hl(0, "LspReferenceRead", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { reverse = true })
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = "NvimLightGreen", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "NvimLightBlue", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "NvimLightCyan", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "NvimLightYellow", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "NvimLightRed", bg = transparent })
  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk"})
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = transparent })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "NormalFloat" })

  local home = "HOME"
  local sep = "/"
  if vim.fn.has("win32") == 1 then
    home = "USERPROFILE"
    sep = "\\"
  end
  local path = os.getenv(home) .. sep .. "github" .. sep .. "dotfiles" .. sep .. "nvim" .. sep .. "init.lua"

  local file = io.open(path, 'r')
  local fileContent = {}
  for line in file:lines() do
      table.insert (fileContent, line)
  end
  io.close(file)

  local name = vim.g.colors_name
  if (name == nil) then name =  "default" end
  fileContent[#fileContent] = "vim.cmd[[colo " .. name .. "]]"


  file = io.open(path, 'w')
  for index, value in ipairs(fileContent) do
      file:write(value..'\n')
  end
  io.close(file)
  if (vim.fn.expand("%:p") == path) then vim.cmd [[e ]] end
end
basic_hl()

vim.api.nvim_create_autocmd("ColorScheme", { callback = basic_hl })
