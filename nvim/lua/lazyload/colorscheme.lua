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
    palette = {
      -- sumiInk0 = "#000000"
      sumiInk0 = "none",
    },
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg = "none",
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      -- Menu
      Pmenu = { fg = "#C5CDD9", bg = colors.palette.sumiInk0 },
      CmpItemMenu = { fg = "#C792EA", bg = colors.palette.sumiInk0 },
      Conceal = { fg = "#455574", bg = colors.palette.sumiInk0, nocombine = true },
      -- Border/Title
      FloatBorder = { fg = "#C5CDD9", bg = colors.palette.sumiInk0 },
      SagaBorder = { link = "FloatBorder" },
      DiagnosticShowBorder = { link = "FloatBorder" },
      CmpCompletionBorder = { link = "FloatBorder" },
      LspInfoBorder = { link = "FloatBorder" },
      TelescopeBorder = { link = "FloatBorder" },
      FloatTitle = { link = "FloatBorder" },
      -- Mics
      IndentBlanklineChar = { fg = colors.palette.sumiInk0, bg = colors.palette.sumiInk0 },
      LazyNormal = { fg = theme.ui.fg_dim, bg = colors.palette.sumiInk0 },
      LspReferenceText = { link = "Visual", nocombine=true },
      LspReferenceWrite = { link = "Visual", nocombine=true },
      MasonNormal = { fg = theme.ui.fg_dim, bg = colors.palette.sumiInk0 },
      NormalFloat = { bg = colors.palette.sumiInk0 },
      SagaBeacon = { bg = "#C5CDD9" },
      SagaNormal = { fg = "#C5CDD9", bg = theme.ui.bg },
      StatusLine = { bg = colors.palette.sumiInk0 },
      StatusLineNC = { bg = colors.palette.sumiInk0 },
      TODOBgFix = { fg = colors.palette.sumiInk0, bg = "#e82424", bold = true },
      TODOBgTODO = { fg = colors.palette.sumiInk0, bg = "#658594", bold = true },
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
