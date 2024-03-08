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
_G.floatw = 120
_G.floath = 30
_G.floatwrap = true

-- file types to trigger nvim-lspconfig
_G.lspfts = { "c", "lua", "cpp", "python", "rust", "zig", "go" }

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

_G.auG = "TuoGroup"

local trsp = "none"
local y, r, b, g, c = "NvimLightYellow", "NvimLightRed", "NvimLightBlue", "NvimLightGreen", "NvimLightCyan"
local gr = "NvimLightGrey4"
local w = "NvimLightGrey1"
local selfg = "#e0def4"

_G.colorset = function()
  vim.api.nvim_set_hl(0, "Error", { fg = trsp })
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = y })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = gr })
  vim.api.nvim_set_hl(0, "SpellBad", { fg = r, underline = true })
  vim.api.nvim_set_hl(0, "SpellCap", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellRare", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellLocal", { link = "SpellBad" })

  vim.api.nvim_set_hl(0, "Normal", { bg = trsp })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = trsp })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = trsp })
  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "Todo", { bg = trsp })

  vim.api.nvim_set_hl(0, "ModeMsg", { fg = w, bold = true })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = selfg, bold = true })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = g, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = b, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = c, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = y, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = r, bg = trsp })

  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Label" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })

  -- Hide all semantic highlights, :h lsp-semantic-highlight
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end
_G.colorset()
