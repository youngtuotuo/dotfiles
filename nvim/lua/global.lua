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
_G.border    = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
_G.floatw    = 120
_G.floath    = 30
_G.floatwrap = true

-- fk u MS
_G.sep   = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home  = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext   = vim.fn.has("win32") == 1 and ".exe" or ""
_G.group = "TuoGroup"

vim.cmd.color [[vim]]
_G.set_highlights = function()
  vim.api.nvim_set_hl(0, "Normal",        { ctermbg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "luaParenError", { link    = "Normal" })
  vim.api.nvim_set_hl(0, "Statement",     { ctermfg = 81,  fg = "#65d1d8", bold = true, nocombine = false })
  vim.api.nvim_set_hl(0, "Boolean",       { ctermfg = 111, fg = "#89aee3", bold = true, nocombine = false })
  vim.api.nvim_set_hl(0, "Function",      { ctermfg = 153, fg = "#9abcdc", bold = true, nocombine = false })
  vim.api.nvim_set_hl(0, "Special",       { ctermfg = 153, fg = "#9abcdc", bold = true, nocombine = false })
  vim.api.nvim_set_hl(0, "Title",         { link = "Function" })
  vim.api.nvim_set_hl(0, "NonText",       { link = "Comment" })
  vim.api.nvim_set_hl(0, "ModeMsg",       { ctermfg = "NONE", fg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "Operator",      { ctermfg = "NONE", fg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat",   { ctermbg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder",   { link    = "Label"})
  vim.api.nvim_set_hl(0, "CursorLine",    { ctermbg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "Conceal",       { ctermbg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn",    { ctermbg = "NONE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "MatchParen",    { ctermfg = 81,  fg = "#65d1d8" })
  vim.api.nvim_set_hl(0, "String",        { ctermfg = 150, fg = "#b7d690" })
  vim.api.nvim_set_hl(0, "Identifier",    { ctermfg = 255, fg = "#eaeaea" })
  vim.api.nvim_set_hl(0, "Comment",       { ctermfg = 244, fg = "#7a7e7a" })
  vim.api.nvim_set_hl(0, "Visual",        { ctermbg = 237, bg = "#393939" })
  vim.api.nvim_set_hl(0, "StatusLineNC",  { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "IlluminatedWordText",        { ctermbg = 241, bg = "#5b5b5b" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead",        { ctermbg = 241, bg = "#5b5b5b" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite",       { ctermbg = 241, bg = "#5b5b5b" })
  vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { link = "Normal" })
end
_G.set_highlights()
