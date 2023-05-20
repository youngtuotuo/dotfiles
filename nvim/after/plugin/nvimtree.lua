if next(vim.api.nvim_list_uis()) ~= nil then
    local HEIGHT_RATIO = 0.8  -- You can change this
    local WIDTH_RATIO = 0.15   -- You can change this too
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        renderer = {
            -- root_folder_label = ":~:s?$?/..?",
            root_folder_label = function(path)
                return string.upper(vim.fn.fnamemodify(path, ":t"))
            end,
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                }
            },
            group_empty = true,
            full_name = false,
            indent_markers = {
              enable = true,
              inline_arrows = true,
              icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
              },
            },
        },
        filters = {
            dotfiles = false,
        },
        view = {
            width = function()
              return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            end,
        },
        -- view = {
        --     float = {
        --         enable = false,
        --         open_win_config = function()
        --           local screen_w = vim.opt.columns:get()
        --           local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        --           local window_w = screen_w * WIDTH_RATIO
        --           local window_h = screen_h * HEIGHT_RATIO
        --           local window_w_int = math.floor(window_w)
        --           local window_h_int = math.floor(window_h)
        --           local center_x = (screen_w - window_w) / 2
        --           local center_y = ((vim.opt.lines:get() - window_h) / 2)
        --                            - vim.opt.cmdheight:get()
        --           return {
        --             border = 'rounded',
        --             relative = 'editor',
        --             row = center_y,
        --             col = center_x,
        --             width = window_w_int,
        --             height = window_h_int,
        --           }
        --         end,
        --     },
        --     width = function()
        --       return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        --     end,
        -- }
    })
    vim.api.nvim_create_user_command('E', 'NvimTreeToggle', {})
    local function open_nvim_tree(data)

        -- open the tree
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then return end

        -- open the tree
        require("nvim-tree.api").tree.open()
    end
    vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})
end
