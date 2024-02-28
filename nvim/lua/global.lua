-- print(vim.inspect(v))
P = function(v)
  print(vim.inspect(v))
  return v
end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
_G.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
_G.floatw = 85
_G.floatwrap = true

-- file types to trigger nvim-lspconfig
_G.lspfts = { "c", "lua", "cpp", "python", "rust", "zig", "go", "tex" }

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

_G.auG = "TuoGroup"

local trsp = "none"
local y, r, b, g, c = "NvimLightYellow", "NvimLightRed", "NvimLightBlue", "NvimLightGreen", "NvimLightCyan"
local gr = "NvimLightGrey4"
local w = "NvimLightGrey1"
local dgr3 = "NvimDarkGrey3"
local dgr1 = "#26233a"
local selfg = "#e0def4"

_G.colorset = function()
  vim.api.nvim_set_hl(0, "Error", { fg = trsp })
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = y })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = gr })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = "#908caa", bg = dgr1 })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = r })
  vim.api.nvim_set_hl(0, "SpellBad", { fg = "Red", underline = true })
  vim.api.nvim_set_hl(0, "SpellCap", { fg = "Red", underline = true })
  vim.api.nvim_set_hl(0, "SpellRare", { fg = "Red", underline = true })
  vim.api.nvim_set_hl(0, "SpellLocal", { fg = "Red", underline = true })

  vim.api.nvim_set_hl(0, "WinBar", { bg = trsp })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = trsp })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = trsp })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = trsp })
  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "Todo", { bg = trsp })
  vim.api.nvim_set_hl(0, "StatusLine", { reverse = true })
  vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })

  vim.api.nvim_set_hl(0, "ModeMsg", { fg = w, bold = true })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = selfg, bold = true })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = g, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = b, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = c, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = y, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = r, bg = trsp })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = dgr3, bg = trsp })

  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Label" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })
end
_G.colorset()
