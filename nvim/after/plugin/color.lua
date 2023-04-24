-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = { bold = false, italic = false},
    keywordStyle = { bold = true, italic = false },
    statementStyle = { bold = false },
    typeStyle = { italic = false},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {
            ui = {
                bg_gutter = "none",
                },
            }
        },
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            NormalFloat = { bg = "#22252a" },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            SagaNormal = { fg = "#C5CDD9", bg = "#22252A" },
            Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
            StatusLine = { bg="NONE" },
            -- NormalFloat = { bg = "NONE"},
            -- LazyNormal = { bg = "NONE", fg = theme.ui.fg_dim },
            -- MasonNormal = { bg = "NONE", fg = theme.ui.fg_dim },
            -- TelescopeTitle = { fg = theme.ui.special, bold = true },
            -- TelescopePromptNormal = { bg = "NONE" },
            -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "NONE" },
            -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "NONE" },
            -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "NONE" },
            -- TelescopePreviewNormal = { bg = "NONE" },
            -- TelescopePreviewBorder = { bg = "NONE", fg = theme.ui.bg_dim },
            -- LspReferenceWrite = {underline = false},
            -- SagaWinbarSep = { fg= "#dcd7ba"},
            -- PmenuSel = { bg = "#282C34", fg = "NONE" },
            -- Pmenu = { fg = "#C5CDD9", bg = "NONE" },
            -- SagaNormal = { fg = "#C5CDD9", bg = "NONE" },
            IndentBlanklineChar = { fg = "#000000" },
            TODOBgTODO = {fg = '#000000', bg="#658594"},
            TODOBgFix = {fg='#000000', bg='#e82424'},
            CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough=true },
            CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold=true  },
            CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold=true  },
            CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic=true },
            CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindProperty = { fg = "#ffffff",  bg = "#b5585f" },
            CmpItemKindEvent = { fg = "#ffffff", bg = "#B5585F" },
            CmpItemKindText = { fg = "#ffffff", bg = "#9FBD73" },
            CmpItemKindEnum = { fg = "#ffffff", bg = "#9FBD73" },
            CmpItemKindKeyword = { fg = "#ffffff", bg = "#9FBD73" },
            CmpItemKindConstant = { fg = "#ffffff", bg = "#D4BB6C" },
            CmpItemKindConstructor = { fg = "#ffffff", bg = "#D4BB6C" },
            CmpItemKindReference = { fg = "#ffffff", bg = "#D4BB6C" },
            CmpItemKindFunction = { fg = "#ffffff", bg = "#A377BF" },
            CmpItemKindStruct = { fg = "#ffffff", bg = "#A377BF" },
            CmpItemKindClass = { fg = "#ffffff", bg = "#A377BF" },
            CmpItemKindModule = { fg = "#ffffff", bg = "#A377BF" },
            CmpItemKindOperator = { fg = "#ffffff", bg = "#A377BF" },
            CmpItemKindVariable = { fg = "#ffffff", bg = "#7E8294" },
            CmpItemKindFile = { fg = "#ffffff", bg = "#7E8294" },
            CmpItemKindUnit = { fg = "#ffffff", bg = "#D4A959" },
            CmpItemKindSnippet = { fg = "#ffffff", bg = "#D4A959" },
            CmpItemKindFolder = { fg = "#ffffff", bg = "#D4A959" },
            CmpItemKindMethod = { fg = "#ffffff", bg = "#6C8ED4" },
            CmpItemKindValue = { fg = "#ffffff", bg = "#6C8ED4" },
            CmpItemKindEnumMember = { fg = "#ffffff", bg = "#6C8ED4" },
            CmpItemKindInterface = { fg = "#ffffff", bg = "#58B5A8" },
            CmpItemKindColor = { fg = "#ffffff", bg = "#58B5A8" },
            CmpItemKindTypeParameter = { fg = "#ffffff", bg = "#58B5A8" },
        }
    end,
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
require("kanagawa").load("wave")

vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {undercurl = true})
-- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal"})
vim.api.nvim_set_hl(0, "VertSplit", { fg = "White" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "White" })
vim.api.nvim_set_hl(0, "Conceal", { fg="#455574", bg = "none", nocombine=true })

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
            {'filetype', colored = true, icon_only = true, icon = {align = 'left'}, padding = {left = 0}},
            {'filename', path = 1}, {
                'lsp_progress',
                display_components = {'spinner'},
                spinner_symbols = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}
            }
        },
        lualine_x = {
            {'location'}
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
