require("oil").setup({
    float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = BORDER,
        win_options = {
            winblend = 10,
        },
    },
})
vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })
vim.api.nvim_create_user_command('E', 'Oil', {})
-- https://github.com/stevearc/oil.nvim#ssh
