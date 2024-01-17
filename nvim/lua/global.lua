-- stylua: ignore start

-- print(vim.inspect(v))
P = function(v) print(vim.inspect(v)) return v end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
_G.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
_G.floatw = 65
_G.floatwrap = true

-- file types to trigger nvim-lspconfig
_G.lspfts = { "c", "lua", "cpp", "python", "rust", "zig", "go" }

-- fk u MS
-- _G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

local transparent = "none"
local y, r, b, g, c = "NvimLightYellow", "NvimLightRed", "NvimLightBlue", "NvimLightGreen", "NvimLightCyan"
local grey = "NvimLightGrey4"
local dgrey3 = "NvimDarkGrey3"
local dgrey1 = "NvimDarkGrey1"

vim.fn.matchadd("EoLSpace", "\\s\\+$")

_G.colorset = function()
  local hls = {
    Error              = { fg = transparent },
    FoldColumn         = { fg = dgrey3, bg = transparent },
    WinBar             = { bg = transparent },
    WinBarNC           = { bg = transparent },
    netrwMarkFile      = { fg = y },
    markdownBlockquote = { fg = grey },
    Pmenu              = { bg = dgrey1 },
    PmenuSel           = { bg = dgrey3 },
    TelescopeSelection = { link = "PmenuSel" },

    LspReferenceText  = { reverse = true },
    LspReferenceRead  = { reverse = true },
    LspReferenceWrite = { reverse = true },

    DiagnosticFloatingOk    = { fg = g, bg = transparent },
    DiagnosticFloatingHint  = { fg = b, bg = transparent },
    DiagnosticFloatingInfo  = { fg = c, bg = transparent },
    DiagnosticFloatingWarn  = { fg = y, bg = transparent },
    DiagnosticFloatingError = { fg = r, bg = transparent },

    DiffAdd    = { link = "DiagnosticFloatingOk" },
    DiffChange = { link = "DiagnosticFloatingWarn" },
    DiffDelete = { link = "DiagnosticFloatingError" },

    NormalFloat = { bg = transparent },
    FloatTitle  = { bg = transparent },
    LspInfoBorder = { link = "Label" },
    FloatBorder = { link = "LspInfoBorder" },
    TelescopeBorder = { link = "LspInfoBorder" },
    TelescopeSelectionCaret = { link = "TelescopeSelection" }
  }
  if vim.o.laststatus == 0 then
    hls.StatusLine   = { link = "WinSeparator" }
    hls.StatusLineNC = { link = "WinSeparator" }
  else
    hls.StatusLine = { reverse = true, bold = true }
  end
  for k, v in pairs(hls) do
    vim.api.nvim_set_hl(0, k, v)
  end

  -- stylua: ignore
  -- update the last line
  local path = os.getenv(_G.home) .. "/github/dotfiles/nvim/init.lua"

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
  for _, value in ipairs(fileContent) do
    file:write(value .. "\n")
  end
  io.close(file)

  if vim.fn.expand("%:p") == path then
    vim.cmd([[e ]])
  end
end
_G.colorset()
