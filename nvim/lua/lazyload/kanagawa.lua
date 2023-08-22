-- Default options:
require("kanagawa").setup({
  compile = true, -- enable compiling the colorscheme
  undercurl = false, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { bold = false, italic = false },
  keywordStyle = { bold = false, italic = false },
  statementStyle = { bold = false },
  typeStyle = { italic = false },
  transparent = TRANS, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    -- local float_bg = theme.ui.bg_m1
    local float_bg = "#111616"
    local tele_border_fg = float_bg
    local status_bg = theme.ui.bg
    if TRANS then
      status_bg = "none"
    end
    return {
      Todo = { bg = float_bg },
      -- Menu
      Pmenu = { link = "NormalFloat" },
      -- Border/Title
      FloatBorder = { fg = theme.ui.fg, bg = float_bg },
      SagaBorder = { link = "FloatBorder" },
      DiagnosticShowBorder = { link = "FloatBorder" },
      CmpCompletionBorder = { link = "FloatBorder" },
      LspInfoBorder = { link = "FloatBorder" },
      TelescopeBorder = { link = "FloatBorder" },
      FloatTitle = { link = "FloatBorder" },
      -- Normal
      NormalFloat = { bg = float_bg },
      LazyNormal = { link = "NormalFloat" },
      MasonNmeormal = { link = "NormalFloat" },
      SagaNormal = { link = "NormalFloat" },
      RenameNormal = { link = "NormalFloat" },
      -- Status line
      StatusLine = { bg = status_bg },
      StatusLineNC = { bg = status_bg },
      -- Mics
      IndentBlanklineChar = { fg = theme.ui.shade0, bg = float_bg },
      -- Highlight
      LspReferenceWrite = { underline = false, standout = true },
      LspReferenceText = { link = "LspReferenceWrite" },
      LspReferenceRead = { link = "LspReferenceWrite" },
      -- window border
      VertSplit = { fg = "White" },
      WinSeparator = { link = "VertSplit" },
      TelescopePromptNormal = {
        bg = float_bg,
      },
      TelescopePromptBorder = {
        bg = float_bg,
        fg = tele_border_fg,
      },
      TelescopePromptTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewNormal = {
        bg = float_bg,
      },
      TelescopePreviewBorder = {
        bg = float_bg,
        fg = tele_border_fg,
      },
      TelescopeResultsTitle = {
        bg = float_bg,
        fg = theme.ui.fg,
      },
      TelescopeResultsNormal = {
        bg = float_bg,
        fg = theme.ui.fg_dim,
      },
      TelescopeResultsBorder = {
        bg = float_bg,
        fg = tele_border_fg,
      },
    }
  end,
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})
require("kanagawa").load("wave") -- wave, dragon, lotus
vim.cmd [[KanagawaCompile]]
