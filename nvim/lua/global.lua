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
_G.floatw = 95
_G.floath = 30
_G.floatwrap = true

-- file types to trigger nvim-lspconfig
_G.lspfts = { "zig" }

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

_G.auG = "TuoGroup"

-- each line's 101-th char get highlighted
vim.fn.matchadd("ColorColumn", [[\%121v]], 100)

-- :h highlight
_G.colorset = function()
  vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { underline = false })
  vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { link = "Label" })
  vim.api.nvim_set_hl(0, "WinSeparator", { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "DarkRed" })
  vim.api.nvim_set_hl(0, "Search", { link = "CurSearch" })

  vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none" })
  vim.api.nvim_set_hl(0, "FloatTitle", { ctermbg = "none" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { ctermfg = "LightGrey" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { ctermfg = "LightGreen", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { ctermfg = "LightBlue", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { ctermfg = "LightCyan", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { ctermfg = "LightYellow", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { ctermfg = "LightRed", ctermbg = "none" })

  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })
end
