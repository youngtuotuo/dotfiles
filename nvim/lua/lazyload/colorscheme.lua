local float_bg = "#111616"
local normal_bg = "#000000"
local sel_bg =  '#151b25'
local menu_bg = "#c6c6c6"
if TRANS then
  normal_bg = "none"
end
local highlights = {
  Normal = { bg = normal_bg },
  -- Menu
  Pmenu = { fg = menu_bg, bg = float_bg },
  PmenuSel = { fg = 'none', bg = sel_bg, bold=true},
  -- Border/Title
  FloatBorder = { fg = menu_bg, bg = float_bg },
  SagaBorder = { link = "FloatBorder" },
  DiagnosticShowBorder = { link = "FloatBorder" },
  CmpCompletionBorder = { link = "FloatBorder" },
  LspInfoBorder = { link = "FloatBorder" },
  TelescopeBorder = { link = "FloatBorder" },
  FloatTitle = { link = "FloatBorder" },
  -- Visual
  Visual = { bg = sel_bg },
  -- Status Line
  StatusLine = { fg = 'DarkGrey', bg = normal_bg },
  StatusLineNC = { fg = menu_bg, bg = normal_bg },
  -- Normal
  NormalFloat = { bg = float_bg },
  LazyNormal = { link = "NormalFloat" },
  MasonNmeormal = { link = "NormalFloat" },
  SagaNormal = { link = "NormalFloat" },
  RenameNormal = { link = "NormalFloat" },
  -- Lsp
  LspReferenceWrite = { underline = false, standout = true },
  LspReferenceText = { link = "LspReferenceWrite" },
  LspReferenceRead = { link = "LspReferenceWrite" },
  -- window border
  VertSplit = { fg = "White" },
  WinSeparator = { link = "VertSplit" },
  -- Telescope
  TelescopePromptNormal = {
    bg = float_bg,
  },
  TelescopePromptBorder = {
    bg = float_bg,
    fg = float_bg,
  },
  TelescopePromptTitle = {
    fg = "DarkGrey",
  },
  TelescopePreviewTitle = {
    fg = "DarkGrey",
  },
  TelescopePreviewNormal = {
    bg = float_bg,
  },
  TelescopePreviewBorder = {
    bg = float_bg,
    fg = float_bg,
  },
  TelescopeResultsTitle = {
    bg = float_bg,
    fg = "DarkGrey",
  },
  TelescopeResultsNormal = {
    bg = float_bg,
    fg = "DarkGrey",
  },
  TelescopeResultsBorder = {
    bg = float_bg,
    fg = float_bg,
  },
}

for name, value in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, value)
end
