local WIDTH_RATIO = 0.1   -- You can change this too
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
        -- root_folder_label = ":~:s?$?/..?",
        root_folder_label = function(path)
            return string.upper(vim.fn.fnamemodify(path, ":t"))
        end,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = false,
                git = true,
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
        custom = { 'mnt' }
    },
    view = {
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
        preserve_window_proportions = false,
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    }
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
