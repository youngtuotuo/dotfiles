-- print(vim.inspect(v))
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Define HLNext function in Lua
_G.flash_cursorline = function(duration_ms, interval_ms)
  vim.opt_local.cursorline = true
  local blink_state = false
  local timer_blink = vim.loop.new_timer()
  local timer_duration = vim.loop.new_timer()

  -- Function to toggle the cursorline
  local function toggle_cursorline()
    blink_state = not blink_state
    vim.opt_local.cursorline = blink_state
  end

  -- Start the blinking timer
  timer_blink:start(0, interval_ms, vim.schedule_wrap(toggle_cursorline))

  -- Stop the blinking after the specified duration
  timer_duration:start(duration_ms, 0, vim.schedule_wrap(function()
    timer_blink:stop()
    timer_blink:close()
    timer_duration:stop() -- Not strictly necessary as it's a one-shot timer
    timer_duration:close()
    vim.opt_local.cursorline = false
  end))
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
_G.lspfts = { "c", "lua", "cpp", "python", "rust", "zig", "go" }

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

_G.auG = "TuoGroup"

-- each line's 101-th char get highlighted
vim.fn.matchadd("ColorColumn", [[\%121v]], 100)

-- :h highlight
local trsp = "none"
_G.colorset = function()
  vim.api.nvim_set_hl(0, "netrwMarkFile", { ctermfg = "LightYellow" })
  vim.api.nvim_set_hl(0, "markdownBlockquote", { ctermfg = "LightGrey" })
  vim.api.nvim_set_hl(0, "Todo", { ctermfg = "Green" })
  vim.api.nvim_set_hl(0, "Warn", { ctermfg = "Red" })
  vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { underline = false })
  vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { link = "Label" })
  vim.api.nvim_set_hl(0, "WinSeparator", { link = "StatusLine" })
  vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "DarkRed" })
  vim.api.nvim_set_hl(0, "Search", { link = "CurSearch" })

  vim.api.nvim_set_hl(0, "SpellBad", { ctermfg = "LightRed", underline = true })
  vim.api.nvim_set_hl(0, "SpellCap", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellRare", { link = "SpellBad" })
  vim.api.nvim_set_hl(0, "SpellLocal", { link = "SpellBad" })

  vim.api.nvim_set_hl(0, "Normal", { ctermbg = trsp })
  vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = trsp })
  vim.api.nvim_set_hl(0, "FloatTitle", { ctermbg = trsp })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { ctermfg = "LightGrey" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "LspInfoBorder" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "LspInfoBorder" })

  vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })

  vim.api.nvim_set_hl(0, "ModeMsg", { ctermfg = "LightGrey", bold = true })

  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { ctermfg = "LightGreen", ctermbg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { ctermfg = "LightBlue", ctermbg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { ctermfg = "LightCyan", ctermbg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { ctermfg = "LightYellow", ctermbg = trsp })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { ctermfg = "LightRed", ctermbg = trsp })

  vim.api.nvim_set_hl(0, "DiffAdd", { link = "DiagnosticFloatingOk" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "DiagnosticFloatingWarn" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "DiagnosticFloatingError" })

  -- Hide all semantic highlights, :h lsp-semantic-highlight
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end
