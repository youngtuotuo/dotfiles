-- Default options:
require("kanagawa").setup({
  compile = true, -- enable compiling the colorscheme
  undercurl = false, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { bold = false, italic = false },
  keywordStyle = { bold = false, italic = false },
  statementStyle = { bold = false },
  typeStyle = { italic = false },
  transparent = true, -- do not set background color
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
    return {
      -- Menu
      Pmenu = { link = "NormalFloat" },
      -- Border/Title
      SagaBorder = { link = "FloatBorder" },
      DiagnosticShowBorder = { link = "FloatBorder" },
      CmpCompletionBorder = { link = "FloatBorder" },
      LspInfoBorder = { link = "FloatBorder" },
      TelescopeBorder = { link = "FloatBorder" },
      FloatTitle = { link = "FloatBorder" },
      -- Normal
      LazyNormal = { link = "NormalFloat" },
      MasonNmeormal = { link = "NormalFloat" },
      SagaNormal = { link = "NormalFloat" },
      RenameNormal = { link = "NormalFloat" },
      -- Status line
      StatusLine = { bg = theme.ui.bg_gutter },
      StatusLineNC = { bg = theme.ui.bg_gutter },
      -- Mics
      IndentBlanklineChar = { fg = theme.ui.shade0, bg = theme.ui.bg },
      -- Highlight
      LspReferenceWrite = { underline = false },
      LspReferenceText = { link = "LspReferenceWrite" },
      LspReferenceRead = { link = "LspReferenceWrite" },
      -- window border
      VertSplit = { fg = "White" },
      WinSeparator = { link = "VertSplit" },
      TelescopePromptNormal = {
        bg = theme.ui.bg_p1,
      },
      TelescopePromptBorder = {
        bg = theme.ui.bg_p1,
        fg = theme.ui.bg_p1,
      },
      TelescopePromptTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewNormal = {
        bg = theme.ui.bg_p2,
      },
      TelescopePreviewBorder = {
        bg = theme.ui.bg_p2,
        fg = theme.ui.bg_p2,
      },
      TelescopeResultsTitle = {
        bg = theme.ui.bg_m1,
        fg = theme.ui.fg,
      },
      TelescopeResultsNormal = {
        bg = theme.ui.bg_m1,
        fg = theme.ui.fg_dim,
      },
      TelescopeResultsBorder = {
        bg = theme.ui.bg_m1,
        fg = theme.ui.bg_m1,
      },
    }
  end,
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})
require("kanagawa").load("wave") -- wave, dragon, lotus
