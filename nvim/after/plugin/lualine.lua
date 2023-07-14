local function LspName()
    local name = vim.lsp.get_active_clients({bufnr=0})[1].name
    return name
end
local auto = require('lualine.themes.auto')
auto.normal.c.bg = 'none'
local config = {
    options = {
        icons_enabled = true,
        theme = auto,
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {statusline = {}, winbar = {}},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {statusline = 1000, tabline = 1000, winbar = 1000}
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {'mode'}, {'%='}, 
            {
                'filetype',
                colored = true,
                icon_only = true,
                icon = {align = 'right'},
                padding = {left = 0}
            },
            {'filename', path = 1, align='left'},
        },
        lualine_x = {
            {'location'}, {LspName, align='right', padding = { right = 0 }},
        },
        lualine_y = {},
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'%='}, {'filename', path = 1}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
}

require('lualine').setup(config)
vim.cmd([[
    augroup lualine_augroup
        autocmd!
        autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
    augroup END
]])
