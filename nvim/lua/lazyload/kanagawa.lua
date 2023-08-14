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
    local tran_bg = theme.ui.bg
    if TRANS then
      tran_bg = "none"
    end
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
      NormalFloat = { bg = tran_bg },
      LazyNormal = { link = "NormalFloat" },
      MasonNmeormal = { link = "NormalFloat" },
      SagaNormal = { link = "NormalFloat" },
      RenameNormal = { link = "NormalFloat" },
      -- Status line
      StatusLine = { bg = tran_bg },
      StatusLineNC = { bg = tran_bg },
      -- Mics
      IndentBlanklineChar = { fg = theme.ui.shade0, bg = tran_bg },
      -- Highlight
      LspReferenceWrite = { underline = false, standout = true },
      LspReferenceText = { link = "LspReferenceWrite" },
      LspReferenceRead = { link = "LspReferenceWrite" },
      -- window border
      VertSplit = { fg = "White" },
      WinSeparator = { link = "VertSplit" },
      TelescopePromptNormal = {
        bg = tran_bg,
      },
      TelescopePromptBorder = {
        bg = tran_bg,
        fg = theme.ui.bg_p1,
      },
      TelescopePromptTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewTitle = {
        fg = theme.ui.fg,
      },
      TelescopePreviewNormal = {
        bg = tran_bg,
      },
      TelescopePreviewBorder = {
        bg = tran_bg,
        fg = theme.ui.bg_p2,
      },
      TelescopeResultsTitle = {
        bg = tran_bg,
        fg = theme.ui.fg,
      },
      TelescopeResultsNormal = {
        bg = tran_bg,
        fg = theme.ui.fg_dim,
      },
      TelescopeResultsBorder = {
        bg = tran_bg,
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
vim.cmd [[KanagawaCompile]]
