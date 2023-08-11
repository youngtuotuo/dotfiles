local function LspName()
  local name = vim.lsp.get_clients({ bufnr = 0 })[1].name
  return name
end
local auto = require("lualine.themes.auto")
auto.normal.c.bg = "none"
if COLORSCHEME == "kanagawa" then
  local colors = require("kanagawa.colors").setup()
  auto.normal.c.fg = colors.theme.fg
elseif COLORSCHEME == "tokyonight" then
  local colors = require("tokyonight.colors").setup()
  auto.normal.c.fg = colors.fg
end
local config = {
  options = {
    icons_enabled = true,
    theme = auto,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = {}, winbar = {} },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filetype",
        colored = true,
        icon_only = true,
        icon = { align = "right" },
        padding = { left = 1 },
      },
      { "filename", path = 1, align = "left" },
    },
    lualine_x = {
      { "location" },
      { LspName, align = "right", padding = { right = 0 } },
      { "progress" },
    },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filetype",
        colored = true,
        icon_only = true,
        icon = { align = "right" },
        padding = { left = 1 },

      },
      { "filename", path = 1, align = "left" },
    },
    lualine_x = {
      { "location" },
      { LspName, align = "right", padding = { right = 0 } },
      { "progress" },
    },
    lualine_y = {},
    lualine_z = {},
  },
}

require("lualine").setup(config)
local lualine_group = vim.api.nvim_create_augroup("lugline_augroup", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  group = lualine_group,
  callback = function()
    require("lualine").refresh()
  end,
})
