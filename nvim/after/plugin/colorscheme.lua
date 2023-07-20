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
        palette = {
            -- sumiInk0 = "#000000"
            sumiInk0 = "none"
        },
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg = "none",
                    bg_gutter = "none"
                }
            }
        }
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            CmpCompletionBorder = {bg = colors.palette.sumiInk0},
            CmpCompletionSel = {bg = "none", underline=true},
            CmpItemAbbrDeprecated = {fg = "#808080", bg = colors.palette.sumiInk0, strikethrough = true},
            CmpItemAbbrMatch = {fg = "#569CD6", bg = colors.palette.sumiInk0, bold = true},
            CmpItemAbbrMatchFuzzy = {link = 'CmpItemAbbrMatch'},
            CmpItemKindClass = {fg = "#A377BF", bg = colors.palette.sumiInk0},
            CmpItemKindColor = {fg = "#58B5A8", bg = colors.palette.sumiInk0},
            CmpItemKindConstant = {fg = "#D4BB6C", bg = colors.palette.sumiInk0},
            CmpItemKindConstructor = {fg = "#D4BB6C", bg = colors.palette.sumiInk0},
            CmpItemKindEnum = {fg = "#9FBD73", bg = colors.palette.sumiInk0},
            CmpItemKindEnumMember = {fg = "#6C8ED4", bg = colors.palette.sumiInk0},
            CmpItemKindEvent = {fg = "#B5585F", bg = colors.palette.sumiInk0},
            CmpItemKindField = {fg = "#B5585F", bg = colors.palette.sumiInk0},
            CmpItemKindFile = {fg = "#7E8294", bg = colors.palette.sumiInk0},
            CmpItemKindFolder = {fg = "#D4A959", bg = colors.palette.sumiInk0},
            ---
            CmpItemKindFunction = {fg = "#C586C0", bg = colors.palette.sumiInk0},
            CmpItemKindMethod = {link='CmpItemKindFunction'},
            ---
            CmpItemKindModule = {fg = "#A377BF", bg = colors.palette.sumiInk0},
            CmpItemKindOperator = {fg = "#A377BF", bg = colors.palette.sumiInk0},
            ---
            CmpItemKindKeyword = {fg = "#D4D4D4", bg = colors.palette.sumiInk0},
            CmpItemKindProperty = {link='CmpItemKindKeyword'},
            CmpItemKindUnit = {link='CmpItemKindKeyword'},
            ---
            CmpItemKindReference = {fg = "#D4BB6C", bg = colors.palette.sumiInk0},
            CmpItemKindSnippet = {fg = "#D4A959", bg = colors.palette.sumiInk0},
            CmpItemKindStruct = {fg = "#A377BF", bg = colors.palette.sumiInk0},
            CmpItemKindTypeParameter = {fg = "#58B5A8", bg = colors.palette.sumiInk0},
            CmpItemKindValue = {fg = "#6C8ED4", bg = colors.palette.sumiInk0},
            ---
            CmpItemKindVariable = {fg = "#9CDCFE", bg = "none"},
            CmpItemKindInterface = {link='CmpItemKindVariable'},
            CmpItemKindText = {link='CmpItemKindVariable'},
            ---
            CmpItemMenu = {fg = "#C792EA", bg = colors.palette.sumiInk0},
            Conceal = {fg = "#455574", bg = colors.palette.sumiInk0, nocombine = true},
            DiagnosticShowBorder = {link = "SagaBorder"},
            FloatBorder = { bg = "none" },
            -- FloatBorder = {bg='none'},
            IndentBlanklineChar = {fg = colors.palette.sumiInk0, bg = "none"},
            LazyNormal = {bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim},
            LspInfoBorder = { bg = colors.palette.sumiInk0 },
            LspReferenceText = {bg = theme.ui.bg_p1},
            LspReferenceWrite = {bg = theme.ui.bg_p1, underline = false},
            MasonNormal = {bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim},
            NormalFloat = {bg = colors.palette.sumiInk0},
            Pmenu = {fg = "#C5CDD9", bg = colors.palette.sumiInk0},
            PmenuSel = {bg = "none", fg = "none", underline=true},
            SagaBeacon = {bg = "#C5CDD9"},
            SagaBorder = {bg = 'none'},
            SagaNormal = {fg = "#C5CDD9", bg = theme.ui.bg},
            StatusLine = {bg = colors.palette.sumiInk0},
            TODOBgFix = {fg = colors.palette.sumiInk0, bg = '#e82424', bold = true},
            TODOBgTODO = {fg = colors.palette.sumiInk0, bg = "#658594", bold = true},
            VertSplit = {fg = "White"},
            Visual = {bg="none", underline=true},
            WinSeparator = {fg = "White"}
        }
    end,
    background = { -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus"
    }
})
require("kanagawa").load("dragon") -- wave, dragon, lotus
