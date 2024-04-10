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

_G.colorset = function()
  vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "DarkRed" })
  vim.api.nvim_set_hl(0, "WinSeparator", { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "Search", { link = "CurSearch" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
end
