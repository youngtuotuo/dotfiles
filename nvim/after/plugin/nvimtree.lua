if next(vim.api.nvim_list_uis()) ~= nil then
    -- local gwidth = vim.api.nvim_list_uis()[1].width
    -- local gheight = vim.api.nvim_list_uis()[1].height
    -- local width = 60
    -- local height = 20
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        renderer = {
            icons = {
                show = {
                    file = true, folder = true, folder_arrow = true, git = true
                }
            },
            group_empty = true
        },
        filters = {dotfiles = false}
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
