-- stylua: ignore start

-- print(vim.inspect(v))
P = function(v) print(vim.inspect(v)) return v end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
BORDER = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

FLOATW = 65
FLOATWRAP = true

-- transparent control
TRANS = true
-- fk u MS
SEP = vim.fn.has("win32") == 1 and [[\]] or "/"
HOME = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
EXT = vim.fn.has("win32") == 1 and ".exe" or ""

local transparent = "none"
local y, r, b, g, c = "NvimLightYellow", "NvimLightRed", "NvimLightBlue", "NvimLightGreen", "NvimLightCyan"
local grey = "NvimLightGrey4"
local dgrey3 = "NvimDarkGrey3"
local dgrey1 = "NvimDarkGrey1"

vim.fn.matchadd("EoLSpace", "\\s\\+$")

COLORSET = function()
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

    LspReferenceText  = { bg = dgrey3 },
    LspReferenceRead  = { bg = dgrey3 },
    LspReferenceWrite = { bg = dgrey3 },

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
    FloatBorder = { link = "LspInfoBorder" },
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
  -- update the last line of                      /github /dotfiles /nvim /init.lua
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
  for _, value in ipairs(fileContent) do
    file:write(value .. "\n")
  end
  io.close(file)

  if vim.fn.expand("%:p") == path then
    vim.cmd([[e ]])
  end
end
COLORSET()
