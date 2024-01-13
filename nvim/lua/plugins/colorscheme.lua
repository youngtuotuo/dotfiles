local transparent = "none"
local function basic_hl()
  local hls = {
    Error = { fg = transparent },
    FoldColumn = { bg = transparent },
    WinBar = { bg = transparent },
    WinBarNC = { bg = transparent },
    netrwMarkFile = { fg = "NvimLightYellow" },
    markdownBlockquote = { fg = "#929292" },

    EoLSpace = { bg = "NvimLightRed" },

    LspReferenceText = { bg = "#453545" },
    LspReferenceRead = { bg = "#453545" },
    LspReferenceWrite = { bg = "#453545" },
    DiagnosticFloatingOk = { fg = "NvimLightGreen", bg = transparent },
    DiagnosticFloatingHint = { fg = "NvimLightBlue", bg = transparent },
    DiagnosticFloatingInfo = { fg = "NvimLightCyan", bg = transparent },
    DiagnosticFloatingWarn = { fg = "NvimLightYellow", bg = transparent },
    DiagnosticFloatingError = { fg = "NvimLightRed", bg = transparent },
    DiffAdd = { link = "DiagnosticFloatingOk" },
    DiffChange = { link = "DiagnosticFloatingWarn" },
    DiffDelete = { link = "DiagnosticFloatingError" },

    NormalFloat = { bg = transparent },
    FloatTitle = { bg = transparent },
    FloatBorder = { link = "LspInfoBorder" },

    IlluminatedWordText = { underline = false },
    IlluminatedWordWrite = { underline = false },
    IlluminatedWordRead = { underline = false },

    DropBarPreview = { bold = true },
    DropBarHover = { fg = "NvimLightCyan", bold = true },
    DropBarCurrentContext = { bold = true },
    DropBarMenuHoverEntry = { fg = "NvimLightCyan", bold = true },
    DropBarMenuCurrentContext = { fg = "NvimLightYellow", bold = false },
  }
  if vim.o.laststatus == 0 then
    hls.StatusLine = { link = "WinSeparator" }
    hls.StatusLineNC = { link = "WinSeparator" }
  else
    hls.StatusLine = { reverse = true, bold = true }
  end
  for k, v in pairs(hls) do
    vim.api.nvim_set_hl(0, k, v)
  end

  -- update the last line of ~/github/dotfiles/nvim/init.lua
  -- stylua: ignore
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
  for index, value in ipairs(fileContent) do
    file:write(value .. "\n")
  end
  io.close(file)

  if vim.fn.expand("%:p") == path then
    vim.cmd([[e ]])
  end
end
basic_hl()
vim.fn.matchadd("EoLSpace", "\\s\\+$")

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TuoGroup", { clear = false }),
  callback = basic_hl,
})

return {}
