local transparent = "none"
local function basic_hl()
  vim.api.nvim_set_hl(0, "Error", { fg = transparent })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = transparent })
  vim.api.nvim_set_hl(0, "WinBar", { bg = transparent })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = transparent })
  if vim.o.laststatus == 0 then
    vim.api.nvim_set_hl(0, "StatusLine", { link = "WinSeparator" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { link = "WinSeparator" })
  else
    vim.api.nvim_set_hl(0, "StatusLine", { reverse = true, bold = true })
  end
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = "NvimLightYellow" })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = "#929292" })

  vim.api.nvim_set_hl(0, "EoLSpace", { bg = "NvimLightRed" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#453545" })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#453545" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#453545" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = "NvimLightGreen", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "NvimLightBlue", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "NvimLightCyan", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "NvimLightYellow", bg = transparent })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "NvimLightRed", bg = transparent })
  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = transparent })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = transparent })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })

  vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })

  vim.api.nvim_set_hl(0, "DropBarPreview", { bold = true })
  vim.api.nvim_set_hl(0, "DropBarHover", { fg = "NvimLightCyan", bold = true })
  vim.api.nvim_set_hl(0, "DropBarCurrentContext", { bold = true })
  vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { fg = "NvimLightCyan", bold = true })
  vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { fg = "NvimLightYellow", bold = false })

  -- update the last line of ~/github/dotfiles/nvim/init.lua
  -- stylua: ignore
  local path = os.getenv(HOME) .. string.format("%sgithub%sdotfiles%snvim%sinit.lua", SEP, SEP, SEP, SEP)

  local file = io.open(path, "r")
  local fileContent = {}
  for line in file:lines() do
    table.insert(fileContent, line)
  end
  io.close(file)

  local name = vim.g.colors_name
  if name == nil then
    name = "default"
  end
  fileContent[#fileContent] = "vim.cmd[[colo " .. name .. "]]"

  file = io.open(path, "w")
  for index, value in ipairs(fileContent) do
    file:write(value .. "\n")
  end
  io.close(file)

  if vim.fn.expand("%:p") == path then
    vim.cmd([[e ]])
  end
end
basic_hl()
vim.fn.matchadd("EoLSpace", "\\s\\+$")

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TuoGroup", { clear = false }),
    callback = basic_hl,
  }
)

return {}
