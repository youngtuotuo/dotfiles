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
