-- print(vim.inspect(v))
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Define HLNext function in Lua
function HLFound(blinktime)
  vim.cmd("set invcursorline")
  vim.cmd("redraw")
  vim.defer_fn(function()
    vim.cmd("set invcursorline")
    vim.cmd("redraw")
  end, blinktime * 1000)
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

-- each line's 101-th char get highlighted
vim.fn.matchadd("ColorColumn", [[\%101v]], 100)

-- :h highlight
local trsp = "none"
_G.colorset = function()
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = "NvimLightYellow" })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = "NvimLightGrey4" })
  vim.api.nvim_set_hl(0, "Todo", { fg = "#10B981" })
  vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { underline = false })
  vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { link = "Label" })
  vim.api.nvim_set_hl(0, "WinSeparator", { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkRed" })

  vim.api.nvim_set_hl(0, "SpellBad", { fg = "NvimLightRed", underline = true })
  vim.api.nvim_set_hl(0, "SpellCap", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellRare", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellLocal", { link = "SpellBad" })

  vim.api.nvim_set_hl(0, "Normal", { bg = trsp })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = trsp })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = trsp })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "NvimLightGrey2" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })

  vim.api.nvim_set_hl(0, "ModeMsg", { fg = "NvimLightGrey1", bold = true })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = "NvimLightGreen", bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "NvimLightBlue", bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "NvimLightCyan", bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "NvimLightYellow", bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "NvimLightRed", bg = trsp })

  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })

  -- Hide all semantic highlights, :h lsp-semantic-highlight
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end
