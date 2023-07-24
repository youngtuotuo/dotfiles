require("lspsaga").setup({
    preview = {lines_above = 0, lines_below = 10},
    scroll_preview = {scroll_down = "<C-f>", scroll_up = "<C-b>"},
    request_timeout = 2000,
    ui = {
        title = true,
        border = BORDER,
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "💡",
        incoming = " ",
        outgoing = " ",
        hover = '  ',
        kind = {}
    },
    beacon = {enable = true, frequency = 20},
    finder = {
        -- percentage
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
            jump_to = 'p',
            edit = {'o', '<CR>'},
            vsplit = 's',
            split = 'i',
            tabe = 't',
            tabnew = 'r',
            quit = {'q', '<ESC>'},
            close_in_preview = '<ESC>'
        }
    },
    outline = {
        win_position = "left",
        win_width = 30,
        preview_width = 0.1,
        auto_preview = false,
        detail = true,
        auto_close = true,
        close_after_jump = false,
        layout = 'normal',
        max_height = 0.8,
        left_width = 0.3,
        keys = {
            toggle_or_jump = 'o',
            quit = "q",
            jump = 'e',
        },
    },
    definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q"
    },
    diagnostic = {
        on_insert = false,
        on_insert_follow = false,
        insert_winblend = 0,
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        max_width = 80,
        max_height = 0.6,
        max_show_width = 80,
        max_show_height = 0.6,
        text_hl_follow = true,
        border_follow = true,
        extend_relatedInformation = false,
        keys = {
            exec_action = 'o',
            quit = 'q',
            expand_or_jump = '<CR>',
            quit_in_show = {'q', '<ESC>'}
        }
    },
    callhierarchy = {
        show_detail = false,
        keys = {
            edit = "e",
            vsplit = "s",
            split = "i",
            tabe = "t",
            jump = "o",
            quit = "q",
            expand_collapse = "u"
        }
    },
    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = false,
        sign_priority = 40,
        virtual_text = true
    },
    symbol_in_winbar = {
        enable = true,
        separator = " 〉",
        ignore_patterns = {},
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = false
    },
    hover = {max_width = 0.9, open_link = 'gx', open_browser = '!chrome'}
})

-- lsp saga
local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
-- keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", default_opts)

-- Code action
keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", default_opts)

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gn", "<cmd>Lspsaga rename<CR>", default_opts)

-- Rename all occurrences of the hovered word for the selected files
-- keymap("n", "gn", "<cmd>Lspsaga rename ++project<CR>", default_opts)

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", default_opts)

-- Go to definition
-- keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", default_opts)

-- Go to type definition
-- keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
-- keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", default_opts)

-- Show cursor diagnostics
-- Like show_line_diagnostics, it supports passing the ++unfocus argument
-- keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Show buffer diagnostics
-- keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
-- keymap("n", "gl", "<cmd>Lspsaga show_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
-- keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", default_opts)
-- keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", default_opts)

-- Diagnostic jump with filters such as only jumping to an error
-- keymap("n", "[E", function()
--   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "]E", function()
--   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)

-- Toggle outline
keymap("n", "<space>o", "<cmd>Lspsaga outline<CR>", default_opts)

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
-- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", default_opts)

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
-- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
-- keymap("n", "<space>ic", "<cmd>Lspsaga incoming_calls<CR>", default_opts)
-- keymap("n", "<space>oc", "<cmd>Lspsaga outgoing_calls<CR>", default_opts)

-- Floating terminal
keymap("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", default_opts)
keymap("t", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", default_opts)
keymap("i", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", default_opts)

