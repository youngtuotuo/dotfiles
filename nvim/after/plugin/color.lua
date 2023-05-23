-- Default options:
require('kanagawa').setup({
    compile = true,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = { bold = false, italic = false},
    keywordStyle = { bold = true, italic = false },
    statementStyle = { bold = false },
    typeStyle = { italic = false},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {
            -- sumiInk0 = "#000000",
        },
        theme = { wave = {}, lotus = {}, dragon = {},
            all = {
                ui = {
                    bg_gutter = "none",
                    bg = "#16161D"
                },
            }
        },
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            CmpCompletionBorder = { bg = colors.palette.sumiInk0},
            CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
            CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
            CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
            CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
            CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
            CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
            CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
            CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
            CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },
            CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
            CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
            CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
            CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
            CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
            CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
            CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
            CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
            CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
            CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
            CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },
            Conceal = { fg="#455574", bg = colors.palette.sumiInk0, nocombine=true },
            DiagnosticShowBorder = { link = "SagaBorder" },
            FloatBorder = { bg = colors.palette.sumiInk0},
            IndentBlanklineChar = { fg = colors.palette.sumiInk0, bg = colors.palette.sumiInk0, nocombine=true },
            LazyNormal = { bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim },
            LspInfoBorder = { bg = colors.palette.sumiInk0 },
            LspReferenceText = { bg = theme.ui.bg_p1, },
            LspReferenceWrite = { bg= theme.ui.bg_p1, underline = false },
            MasonNormal = { bg = colors.palette.sumiInk0, fg = theme.ui.fg_dim },
            NormalFloat = { bg = colors.palette.sumiInk0},
            Pmenu = { fg = "#C5CDD9", bg = theme.ui.bg_m3},
            PmenuSel = { bg = "#282C34", fg = "NONE" },
            SagaBeacon = { bg = "#C5CDD9" },
            SagaBorder = { bg = colors.palette.sumiInk0},
            SagaNormal = { fg = "#C5CDD9", bg = theme.ui.bg},
            StatusLine = { bg = colors.palette.sumiInk0},
            TODOBgFix = {fg = colors.palette.sumiInk0, bg='#e82424', bold=true},
            TODOBgTODO = {fg = colors.palette.sumiInk0, bg="#658594", bold=true},
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            VertSplit = { fg="White" },
            WinSeparator = { fg = "White"},
        }
    end,
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
require("kanagawa").load("wave") -- wave, dragon, lotus


require('lsp-progress').setup({
    -- Spinning icons.
    -- spinner = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾", },
    spinner = { "┤", "┘", "┴", "└", "├", "┌", "┬", "┐"},

    -- Spinning update time in milliseconds.
    spin_update_time = 100,

    -- Last message cached decay time in milliseconds.
    --
    -- Message could be really fast(appear and disappear in an
    -- instant) that user cannot even see it, thus we cache the last message
    -- for a while for user view.
    decay = 1000,

    -- User event name.
    event = "LspProgressStatusUpdated",

    -- Event update time limit in milliseconds.
    --
    -- Sometimes progress handler could emit many events in an instant, while
    -- refreshing statusline cause too heavy synchronized IO, so we limit the
    -- event rate to reduce this cost.
    event_update_time_limit = 100,

    --- Max progress string length, by default -1 is unlimit.
    max_size = -1,

    -- Format series message.
    --
    -- By default it looks like: `formatting isort (100%) - done`.
    --
    -- @param title      Message title.
    -- @param message    Message body.
    -- @param percentage Progress in percentage numbers: [0%-100%].
    -- @param done       Indicate if this message is the last one in progress.
    -- @return           A nil|string|table value. The returned value will be
    --                   passed to function `client_format` as one of the
    --                   `series_messages` array, or ignored if return nil.
    series_format = function(title, message, percentage, done)
        local builder = {}
        local has_title = false
        local has_message = false
        if title and title ~= "" then
            table.insert(builder, title)
            has_title = true
        end
        if message and message ~= "" then
            table.insert(builder, message)
            has_message = true
        end
        if percentage and (has_title or has_message) then
            table.insert(builder, string.format("(%.0f%%%%)", percentage))
        end
        if done and (has_title or has_message) then
            table.insert(builder, "- done")
        end
        return table.concat(builder, " ")
    end,

    -- Format client message.
    --
    -- By default it looks like:
    -- `[null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`.
    --
    -- @param client_name     Client name.
    -- @param spinner         Spinner icon.
    -- @param series_messages Series messages array.
    -- @return                A nil|string|table value. The returned value will
    --                        be passed to function `format` as one of the
    --                        `client_messages` array, or ignored if return nil.
    client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
                and ("[" .. client_name .. "] " .. spinner .. " " --[[..  table.concat( ]]
                    -- series_messages,
                    -- ", "
                    -- )
                )
            or ("[" .. client_name .. "]")
    end,

    -- Format (final) message.
    --
    -- By default it looks like:
    -- ` LSP [null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`
    --
    -- @param client_messages Client messages array.
    -- @return                A nil|string|table value. The returned value will be
    --                        returned from `progress` API.
    format = function(client_messages)
        return #client_messages > 0
                and (table.concat(client_messages, " "))
            or ""
    end,

    --- Enable debug.
    debug = false,

    --- Print log to console(command line).
    console_log = true,

    --- Print log to file.
    file_log = false,

    -- Log file to write, work with `file_log=true`.
    -- For Windows: `$env:USERPROFILE\AppData\Local\nvim-data\lsp-progress.log`.
    -- For *NIX: `~/.local/share/nvim/lsp-progress.log`.
    file_log_name = "lsp-progress.log",
})
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
                require('lsp-progress').progress,
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
vim.cmd([[
    augroup lualine_augroup
        autocmd!
        autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
    augroup END
]])
