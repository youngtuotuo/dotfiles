local g = require("tuo.global")
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = g.trans, -- Enable this to disable setting the background color
  terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})

vim.cmd([[colorscheme tokyonight]])

local transparent = "none"
local blue = "#82aaff"
local dim = "#222436"
local fg = "#c8d3f5"
local fg_dark = "#828bb8"
local float_bg = "#3b4261"
local border_fg = "#589ed7"
local lsp_reference_bg = "#2f334d"
vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = float_bg })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_fg, bg = float_bg })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = false, bg = lsp_reference_bg, standout = true })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = transparent })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fg_dark, bg = transparent })
vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = fg, bg = float_bg })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = float_bg, bg = float_bg })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = float_bg, bg = float_bg })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = float_bg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = float_bg })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = blue, bg = dim })
vim.api.nvim_set_hl(0, "@text.literal.markdown_inline", { bg = transparent })
vim.api.nvim_set_hl(0, "Todo", { fg = "#10B981", bg = transparent })
vim.api.nvim_set_hl(0, "SignColumnSB", { bg = transparent })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#cccccc" })
vim.api.nvim_set_hl(0, "EoLSpace", { bg = "#884455" })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = dim, bg = blue })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = blue })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = blue })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = blue })
-- link
vim.api.nvim_set_hl(0, "NormalSB", { link = "Normal" })
vim.api.nvim_set_hl(0, "luaParenError", { link = "Normal" })
vim.api.nvim_set_hl(0, "SagaBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "DiagnosticShowBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "CmpCompletionBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "Sagatitle", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "LazyNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "MasonNmeormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "SagaNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "RenameNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "LspReferenceText", { link = "LspReferenceWrite" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceWrite" })
vim.api.nvim_set_hl(0, "VertSplit", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "IdlIndent", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "WinSeparator", { link = "VertSplit" })
