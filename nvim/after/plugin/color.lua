require("onedark").setup({
    style = 'deep',
    ending_tildes = true,
    cmp_itemkind_reverse = true,
    lualine = {
        transparent = true -- lualine center bar transparency
    },
    diagnostics = {undercurl = true, background = true}
})
require("onedark").load()
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {undercurl = true})

local config = {
    options = {
        icons_enabled = true,
        theme = 'auto',
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
            {'filetype', colored = true, icon_only = true, icon = {align = 'left'}, padding = {left = 0}},
            {'filename', path = 1}, {
                'lsp_progress',
                display_components = {'spinner'},
                spinner_symbols = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}
            }
        },
        lualine_x = {
            {
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = ' '
            }, {'location'}
        },
        lualine_y = {},
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'%='}, {'filename', path = 1}},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require('lualine').setup(config)
