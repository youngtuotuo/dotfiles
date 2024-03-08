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

-- :h highlight
local trsp = "none"
local nly, nlr, nlb, nlg, nlc = "NvimLightYellow", "NvimLightRed", "NvimLightBlue", "NvimLightGreen", "NvimLightCyan"
local nlg4 = "NvimLightGrey4"
local nlg1 = "NvimLightGrey1"
local ndg1 = "NvimDarkGrey4"

_G.colorset = function()
  vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = nly })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = nlg4 })

  vim.api.nvim_set_hl(0, "SpellBad", { fg = nlr, underline = true })
  vim.api.nvim_set_hl(0, "SpellCap", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellRare", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellLocal", { link = "SpellBad" })

  vim.api.nvim_set_hl(0, "Normal", { bg = trsp })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = trsp })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = trsp })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = ndg1 })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })

  vim.api.nvim_set_hl(0, "ModeMsg", { fg = nlg1, bold = true })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = nlg, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = nlb, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = nlc, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = nly, bg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = nlr, bg = trsp })

  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })

  -- Hide all semantic highlights, :h lsp-semantic-highlight
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
  vim.api.nvim_set_hl(0, "Todo", {})
end
_G.colorset()
