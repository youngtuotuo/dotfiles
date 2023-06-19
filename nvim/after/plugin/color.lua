-- Default options:
require('kanagawa').setup({
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = {italic = false},
    functionStyle = {bold = false, italic = false},
    keywordStyle = {bold = true, italic = false},
    statementStyle = {bold = false},
    typeStyle = {italic = false},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
        palette = {sumiInk0 = "#000000"},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg_gutter = "none",
                    -- bg = "#16161D"
                    bg = "#000000"
                }
            }
        }
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            CmpCompletionBorder = {bg = colors.palette.sumiInk0},
            CmpItemAbbrDeprecated = {
                fg = "#7E8294",
                bg = "NONE",
                strikethrough = true
            },
            CmpItemAbbrMatch = {fg = "#82AAFF", bg = "NONE", bold = true},
            CmpItemAbbrMatchFuzzy = {fg = "#82AAFF", bg = "NONE", bold = true},
            CmpItemKindClass = {fg = "#EADFF0", bg = "#A377BF"},
            CmpItemKindColor = {fg = "#D8EEEB", bg = "#58B5A8"},
            CmpItemKindConstant = {fg = "#FFE082", bg = "#D4BB6C"},
            CmpItemKindConstructor = {fg = "#FFE082", bg = "#D4BB6C"},
            CmpItemKindEnum = {fg = "#C3E88D", bg = "#9FBD73"},
            CmpItemKindEnumMember = {fg = "#DDE5F5", bg = "#6C8ED4"},
            CmpItemKindEvent = {fg = "#EED8DA", bg = "#B5585F"},
            CmpItemKindField = {fg = "#EED8DA", bg = "#B5585F"},
            CmpItemKindFile = {fg = "#C5CDD9", bg = "#7E8294"},
            CmpItemKindFolder = {fg = "#F5EBD9", bg = "#D4A959"},
            CmpItemKindFunction = {fg = "#EADFF0", bg = "#A377BF"},
            CmpItemKindInterface = {fg = "#D8EEEB", bg = "#58B5A8"},
            CmpItemKindKeyword = {fg = "#C3E88D", bg = "#9FBD73"},
            CmpItemKindMethod = {fg = "#DDE5F5", bg = "#6C8ED4"},
            CmpItemKindModule = {fg = "#EADFF0", bg = "#A377BF"},
            CmpItemKindOperator = {fg = "#EADFF0", bg = "#A377BF"},
            CmpItemKindProperty = {fg = "#EED8DA", bg = "#B5585F"},
            CmpItemKindReference = {fg = "#FFE082", bg = "#D4BB6C"},
            CmpItemKindSnippet = {fg = "#F5EBD9", bg = "#D4A959"},
            CmpItemKindStruct = {fg = "#EADFF0", bg = "#A377BF"},
            CmpItemKindText = {fg = "#C3E88D", bg = "#9FBD73"},
            CmpItemKindTypeParameter = {fg = "#D8EEEB", bg = "#58B5A8"},
            CmpItemKindUnit = {fg = "#F5EBD9", bg = "#D4A959"},
            CmpItemKindValue = {fg = "#DDE5F5", bg = "#6C8ED4"},
            CmpItemKindVariable = {fg = "#C5CDD9", bg = "#7E8294"},
            CmpItemMenu = {fg = "#C792EA", bg = "NONE", italic = true},
            Conceal = {
                fg = "#455574",
                bg = colors.palette.sumiInk0,
                nocombine = true
            },
            DiagnosticShowBorder = {link = "SagaBorder"},
            -- FloatBorder = { bg = colors.palette.sumiInk0},
            FloatBorder = {bg = 'none'},
            IndentBlanklineChar = {
                fg = colors.palette.sumiInk0,
                bg = colors.palette.sumiInk0,
                nocombine = true
            },
            LazyNormal = {bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim},
            -- LspInfoBorder = { bg = colors.palette.sumiInk0 },
            LspInfoBorder = {bg = 'none'},
            LspReferenceText = {bg = theme.ui.bg_p1},
            LspReferenceWrite = {bg = theme.ui.bg_p1, underline = false},
            MasonNormal = {bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim},
            NormalFloat = {bg = colors.palette.sumiInk0},
            Pmenu = {fg = "#C5CDD9", bg = theme.ui.bg_m3},
            PmenuSel = {bg = "#282C34", fg = "none"},
            SagaBeacon = {bg = "#C5CDD9"},
            SagaBorder = {bg = 'none'},
            SagaNormal = {fg = "#C5CDD9", bg = theme.ui.bg},
            StatusLine = {bg = colors.palette.sumiInk0},
            TODOBgFix = {
                fg = colors.palette.sumiInk0,
                bg = '#e82424',
                bold = true
            },
            TODOBgTODO = {
                fg = colors.palette.sumiInk0,
                bg = "#658594",
                bold = true
            },
            -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = {bg = '#000000', fg = '#000000'},
            TelescopePreviewNormal = {bg = '#000000'},
            TelescopePromptBorder = {fg = theme.ui.bg_p1, bg = theme.ui.bg_p1},
            TelescopePromptNormal = {bg = theme.ui.bg_p1},
            TelescopeResultsBorder = {fg = theme.ui.bg_m1, bg = theme.ui.bg_m1},
            TelescopeResultsNormal = {fg = theme.ui.fg_dim, bg = theme.ui.bg_m1},
            TelescopeTitle = {fg = theme.ui.special, bold = true},
            VertSplit = {fg = "White"},
            WinSeparator = {fg = "White"}
        }
    end,
    background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus"
    }
})
require("kanagawa").load("wave") -- wave, dragon, lotus

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
            {LspName, align='right', padding = { right = 0 }},
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
