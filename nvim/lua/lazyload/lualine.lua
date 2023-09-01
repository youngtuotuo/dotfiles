local function progressIndicatorIterator(strings)
  local index = 1
  return function()
    if index <= #strings then
      local str = strings[index]
      index = index + 1
      return str
    else
      index = 1
      return strings[index]
    end
  end
end
-- Global variable to keep status
local progress_string = progressIndicatorIterator({
  "🌑 ",
  "🌒 ",
  "🌓 ",
  "🌔 ",
  "🌕 ",
  "🌖 ",
  "🌗 ",
  "🌘 ",
})

local count = 0
local count_thres = 40
local function lsp_progress()
  if vim.lsp.status() == "" then
    if count <= count_thres then
      count = count + 1
    end
    if count >= count_thres then
      return "%l,%c%V%14.6P"
    elseif count >= count_thres - 20 then
      return vim.lsp.get_clients({ bufnr = 0 })[1].name .. "  "
    else
      return vim.lsp.get_clients({ bufnr = 0 })[1].name .. " " .. progress_string()
    end
  else
    count = 0
    return vim.lsp.get_clients({ bufnr = 0 })[1].name .. " " .. progress_string()
  end
end

local auto = require("lualine.themes.auto")
auto.normal.c.bg = "none"
if COLORSCHEME == "kanagawa" then
  local colors = require("kanagawa.colors").setup()
  auto.normal.c.fg = colors.theme.fg
elseif COLORSCHEME == "tokyonight" then
  local colors = require("tokyonight.colors").setup()
  auto.normal.c.fg = colors.fg
elseif COLORSCHEME == "lunaperche" or COLORSCHEME == "habamax" or COLORSCHEME == "rose-pine" then
  if TRANS then
    auto.normal.c.bg = "none"
    auto.command.c.bg = "none"
    auto.visual.c.bg = "none"
    auto.inactive.c.bg = "none"
    auto.replace.c.bg = "none"
    auto.insert.c.bg = "none"
  else
    auto.normal.c.bg = "#000000"
    auto.command.c.bg = "#000000"
    auto.visual.c.bg = "#000000"
    auto.inactive.c.bg = "#000000"
    auto.replace.c.bg = "#000000"
    auto.insert.c.bg = "#000000"
  end
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
    refresh = { statusline = 100, tabline = 1000, winbar = 1000 },
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
      { lsp_progress },
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
      { lsp_progress },
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
