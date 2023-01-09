require("onedark").setup({
    style = 'deep'
})
require("onedark").load()
-- require('rose-pine').setup({
--     --- @usage 'main' | 'moon'
--     dark_variant = 'moon',
--     bold_vert_split = false,
--     dim_nc_background = false,
--     disable_background = false,
--     disable_float_background = false,
--     disable_italics = true,
--
--     --- @usage string hex value or named color from rosepinetheme.com/palette
--     groups = {
--         background = 'base',
--         panel = 'surface',
--         border = 'highlight_med',
--         comment = 'muted',
--         link = 'iris',
--         punctuation = 'subtle',
--
--         error = 'love',
--         hint = 'iris',
--         info = 'foam',
--         warn = 'gold',
--
--         headings = {h1 = 'iris', h2 = 'foam', h3 = 'rose', h4 = 'gold', h5 = 'pine', h6 = 'foam'}
--         -- or set all headings at once
--         -- headings = 'subtle'
--     },
--
--     -- Change specific vim highlight groups
--     highlight_groups = {ColorColumn = {bg = 'rose'}}
-- })
-- vim.cmd.colorscheme("rose-pine")
-- -- vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
-- -- vim.api.nvim_set_hl(0, "NoiceMini", {bg = "none"})
-- -- vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
-- -- vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
-- -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
-- vim.api.nvim_set_hl(0, "FloatBorder", {fg = "#9ccfd8"})
-- vim.api.nvim_set_hl(0, "TelescopeBorder", {fg = "#9ccfd8"})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {undercurl = true})

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg = 'none',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
}

-- Config
local config = {
    options = {
        icons_enabled = true,
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = {c = {fg = colors.fg, bg = colors.bg}},
            inactive = {c = {fg = colors.fg, bg = colors.bg}}
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    }
}


local mode_color_text = {
    ['n'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['no'] = {color = colors.red, text = ' O-PENDING'}, -- 'O-PENDING',
    ['nov'] = {color = colors.red, text = ' O-PENDING'}, -- 'O-PENDING',
    ['noV'] = {color = colors.red, text = ' O-PENDING'}, -- 'O-PENDING',
    ['no\22'] = {color = colors.red, text = ' O-PENDING'}, -- 'O-PENDING',
    ['niI'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['niR'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['niV'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['nt'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['ntT'] = {color = colors.blue, text = ' (つ´ω`)つ'}, -- 'NORMAL',
    ['v'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'VISUAL',
    ['vs'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'VISUAL',
    ['V'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'V-LINE',
    ['Vs'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'V-LINE',
    ['\22'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'V-BLOCK',
    ['\22s'] = {color = colors.green, text = ' d(`･∀･)b'}, -- 'V-BLOCK',
    ['s'] = {color = colors.orange, text = ' SELECT'}, -- 'SELECT',
    ['S'] = {color = colors.orange, text = ' SELECT'}, -- 'S-LINE',
    ['\19'] = {color = colors.orange, text = ' SELECT'}, -- 'S-BLOCK',
    ['i'] = {color = colors.green, text = ' ヽ(✿ﾟ▽ﾟ)ノ'}, -- 'INSERT',
    ['ic'] = {color = colors.green, text = ' ヽ(✿ﾟ▽ﾟ)ノ'}, -- 'INSERT',
    ['ix'] = {color = colors.green, text = ' ヽ(✿ﾟ▽ﾟ)ノ'}, -- 'INSERT',
    ['R'] = {color = colors.violet, text = ' REPLACE'}, -- 'REPLACE',
    ['Rc'] = {color = colors.violet, text = ' REPLACE'}, -- 'REPLACE',
    ['Rx'] = {color = colors.violet, text = ' REPLACE'}, -- 'REPLACE',
    ['Rv'] = {color = colors.violet, text = ' REPLACE'}, -- 'V-REPLACE',
    ['Rvc'] = {color = colors.violet, text = ' REPLACE'}, -- 'V-REPLACE',
    ['Rvx'] = {color = colors.violet, text = ' REPLACE'}, -- 'V-REPLACE',
    ['c'] = {color = colors.yellow, text = ' (σﾟ∀ﾟ)σ'}, -- 'COMMAND',
    ['cv'] = {color = colors.red, text = ' EX'}, -- 'EX',
    ['ce'] = {color = colors.red, text = ' EX'}, -- 'EX',
    ['r'] = {color = colors.cyan, text = ' REPLACE'}, -- 'REPLACE',
    ['rm'] = {color = colors.cyan, text = ' MORE'}, -- 'MORE',
    ['r?'] = {color = colors.cyan, text = ' CONFIRM'}, -- 'CONFIRM',
    ['!'] = {color = colors.red, text = ' SHELL'}, -- 'SHELL',
    ['t'] = {color = colors.red, text = ' TERMINAL'} -- 'TERMINAL',
}


-- Inserts a component in lualine_c at left section
local function ins_left(component) table.insert(config.sections.lualine_c, component) end

ins_left {
    function() return mode_color_text[vim.fn.mode()].text end,
    color = function() return {fg = mode_color_text[vim.fn.mode()].color} end,
    padding = {right = 1}
}

-- ins_left {'branch', icon = '', color = {fg = colors.violet, gui = 'bold'}}

-- Insert mid section. You can make any number of sections in neovim :)
-- test for lualine it's any number greater then 2
ins_left {function() return '%=' end}

ins_left {
    'filetype',
    colored = true,
    icon_only = true,
    icon = {align='left'},
    padding = {left=0}
}

ins_left {
    'filename',
    path = 1,
}

ins_left {
    'lsp_progress',
    display_components = {'spinner'},
    spinner_symbols = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },

}

-- Inserts a component in lualine_x ot right section
local function ins_right(component) table.insert(config.sections.lualine_x, component) end

ins_right {
    -- Lsp server name .
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
        end
        return msg
    end,
    icon = ' ',
    -- color = {fg = '#ffffff'}
}

-- ins_right {
--     'diagnostics',
--     sources = {'nvim_diagnostic'},
--     symbols = {error = ' ', warn = ' ', info = ' '},
--     diagnostics_color = {
--         color_error = {fg = colors.red},
--         color_warn = {fg = colors.yellow},
--         color_info = {fg = colors.cyan}
--     }
-- }

ins_right {'location'}

-- Now don't forget to initialize lualine
lualine.setup(config)
