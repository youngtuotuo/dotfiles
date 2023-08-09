-- Default options:
require("kanagawa").setup({
  compile = true, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { bold = false, italic = false },
  keywordStyle = { bold = false, italic = false },
  statementStyle = { bold = false },
  typeStyle = { italic = false },
  transparent = false, -- do not set background color
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
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      Conceal = { fg = "#455574", bg = theme.ui.bg, nocombine = true },
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
      StatusLine = { bg = theme.ui.bg },
      StatusLineNC = { bg = theme.ui.bg },
      -- Mics
      IndentBlanklineChar = { fg = theme.ui.shade0, bg = theme.ui.bg },
      LspReferenceText = { nocombine = true, standout = true },
      LspReferenceWrite = { nocombine = true, standout = true, underline = false },
      LspReferenceRead = { nocombine = true, standout = true },
      VertSplit = { fg = "White" },
      WinSeparator = { link = "VertSplit" },
      -- Telescope
      TelescopeNormal = {
        bg = theme.ui.bg_p1,
        fg = theme.ui.fg,
      },
      TelescopeBorder = {
        bg = theme.ui.bg_p1,
        fg = theme.ui.bg_p1,
      },
      TelescopePromptNormal = {
        bg = theme.ui.bg_p2,
      },
      TelescopePromptBorder = {
        bg = theme.ui.bg_p2,
        fg = theme.ui.bg_p2,
      },
      TelescopePromptTitle = {
        bg = theme.ui.bg_p2,
        fg = theme.ui.bg_p2,
      },
      TelescopePreviewTitle = {
        bg = theme.ui.bg_p1,
        fg = theme.ui.bg_p1,
      },
      TelescopeResultsTitle = {
        bg = theme.ui.bg_p1,
        fg = theme.ui.bg_p1,
      },
    }
  end,
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})
require("kanagawa").load("wave") -- wave, dragon, lotus
