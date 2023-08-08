-- Default options:
require("kanagawa").setup({
  compile = true, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { bold = false, italic = false },
  keywordStyle = { bold = true, italic = false },
  statementStyle = { bold = false },
  typeStyle = { italic = false },
  transparent = false, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    theme = {
      all = {
        ui = {
          -- bg = "none",
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      -- Menu
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      Conceal = { fg = "#455574", bg = theme.ui.bg, nocombine = true },
      -- Border/Title
      FloatBorder = { fg = "#C5CDD9", bg = theme.ui.bg },
      SagaBorder = { link = "FloatBorder" },
      DiagnosticShowBorder = { link = "FloatBorder" },
      CmpCompletionBorder = { link = "FloatBorder" },
      LspInfoBorder = { link = "FloatBorder" },
      TelescopeBorder = { link = "FloatBorder" },
      FloatTitle = { link = "FloatBorder" },
      -- Normal
      NormalFloat = { fg = theme.ui.fg_dim, bg = theme.ui.bg, nocombine = true },
      LazyNormal = { link = "NormalFloat" },
      MasonNmeormal = { link = "NormalFloat" },
      SagaNormal = { link = "NormalFloat" },
      TelescopeNormal = { link = "NormalFloat" },
      TelescopePromptNormal = { link = "NormalFloat" },
      TelescopePreviewNormal = { link = "NormalFloat" },
      TelescopeResultsNormal = { link = "NormalFloat" },
      RenameNormal = { link = "NormalFloat" },
      StatusLine = { bg = theme.ui.bg },
      StatusLineNC = { bg = theme.ui.bg },
      -- Mics
      IndentBlanklineChar = { fg = theme.ui.shade0, bg = theme.ui.bg },
      LspReferenceText = { nocombine = true, standout = true },
      LspReferenceWrite = { nocombine = true, standout = true },
      LspReferenceRead = { nocombine = true, standout = true },
      SagaBeacon = { bg = "#C5CDD9" },
      TODOBgFix = { fg = theme.ui.bg, bg = "#e82424", bold = true },
      TODOBgTODO = { fg = theme.ui.bg, bg = "#658594", bold = true },
      VertSplit = { fg = "White" },
      WinSeparator = { link = "VertSplit" },
    }
  end,
  background = { -- map the value of 'background' option to a theme
    dark = "dragon", -- try "dragon" !
    light = "lotus",
  },
})
require("kanagawa").load("wave") -- wave, dragon, lotus
