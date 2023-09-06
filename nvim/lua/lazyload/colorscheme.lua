require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = TRANS, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
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

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    local prompt = "#2d3149"
    -- local float_bg = colors.bg_dark
    local float_bg = "#151b25"
    local tele_border_fg = float_bg
    local status_bg = colors.bg
    if TRANS then
      status_bg = "none"
    end
    highlights.NormalSB = { link = "Normal" }
    highlights.Pmenu = { bg = float_bg }
    highlights.FloatBorder = { fg = colors.border_highlight, bg = float_bg }
    highlights.SagaBorder = { link = "FloatBorder" }
    highlights.DiagnosticShowBorder = { link = "FloatBorder" }
    highlights.CmpCompletionBorder = { link = "FloatBorder" }
    highlights.LspInfoBorder = { link = "FloatBorder" }
    highlights.TelescopeBorder = { link = "FloatBorder" }
    highlights.FloatTitle = { link = "FloatBorder" }
    highlights.NormalFloat = { fg = colors.fg, bg = float_bg }
    highlights.LazyNormal = { link = "NormalFloat" }
    highlights.MasonNmeormal = { link = "NormalFloat" }
    highlights.SagaNormal = { link = "NormalFloat" }
    highlights.RenameNormal = { link = "NormalFloat" }
    highlights.LspReferenceWrite = { underline = false, bg = colors.bg_highlight, standout = true }
    highlights.LspReferenceText = { link = "LspReferenceWrite" }
    highlights.LspReferenceRead = { link = "LspReferenceWrite" }
    highlights.VertSplit = { fg = "White" }
    highlights.WinSeparator = { link = "VertSplit" }
    highlights.StatusLine = { fg = colors.fg, bg = status_bg }
    highlights.StatusLineNC = { fg = colors.fg_dark, bg = status_bg }
    highlights.luaParenError = { link = "Normal" }
    highlights.SignColumnSB = { bg = "none" }
    highlights.TelescopeNormal = {
      bg = float_bg,
      fg = colors.fg,
    }
    highlights.TelescopeBorder = {
      bg = float_bg,
      fg = tele_border_fg,
    }
    highlights.TelescopePromptNormal = {
      bg = float_bg
    }
    highlights.TelescopePromptBorder = {
      bg = float_bg,
      fg = tele_border_fg,
    }
    highlights.TelescopePromptTitle = {
      bg = float_bg,
      fg = colors.fg_dark,
    }
    highlights.TelescopePreviewTitle = {
      bg = float_bg,
      fg = colors.fg_dark,
    }
    highlights.TelescopeResultsTitle = {
      bg = float_bg,
      fg = colors.fg_dark,
    }
  end,
})

vim.cmd([[colorscheme tokyonight]])
