local status_bg = "none"
local float_bg = "#111616"
local menu_bg = "surface"
require("rose-pine").setup({
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = "main",
  --- @usage 'main'|'moon'|'dawn'
  dark_variant = "main",
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = true,
  disable_float_background = false,
  disable_italics = true,

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = "base",
    background_nc = "_experimental_nc",
    panel = "surface",
    panel_nc = "base",
    border = "highlight_med",
    comment = "muted",
    link = "iris",
    punctuation = "subtle",

    error = "love",
    hint = "iris",
    info = "foam",
    warn = "gold",

    headings = {
      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
    -- or set all headings at once
    -- headings = 'subtle'
  },

  -- Change specific vim highlight groups
  -- https://github.com/rose-pine/neovim/wiki/Recipes
  highlight_groups = {
    ColorColumn = { bg = "base" },
    -- Menu
    Pmenu = { link = "NormalFloat" },
    -- Border/Title
    FloatBorder = { fg = menu_bg, bg = float_bg },
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
    -- Lsp
    LspReferenceWrite = { underline = false, standout = true },
    LspReferenceText = { link = "LspReferenceWrite" },
    LspReferenceRead = { link = "LspReferenceWrite" },
    luaParenError = { fg = "Text", bg = "none" },
    -- window border
    VertSplit = { fg = "White" },
    WinSeparator = { link = "VertSplit" },
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
  },
})

-- Set colorscheme after options
vim.cmd("colorscheme rose-pine")
