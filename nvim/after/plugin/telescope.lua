local status_ok, _ = pcall(require, "telescope")
if not status_ok then return end

local actions = require 'telescope.actions'

require("telescope").setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
        prompt_prefix = "> ",
        selection_caret = " ",
        path_display = {"smart"},
        initial_mode = "insert",
        mappings = {
            n = {
                ["q"] = actions.close,
                ["<C-c>"] = actions.close,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous
            },
            i = {
                ["<C-c>"] = actions.close,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous
            }
        },
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u'
        }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        workspaces = {
            -- keep insert mode after selection in the picker, default is false
            keep_insert = false
        }
    }
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


local default_opts = {noremap = true, silent = true}
-- Telescope Stuff
vim.api.nvim_set_keymap("n", "<space>r", ":Telescope lsp_references<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>e", ":Telescope find_files<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>f", ":Telescope current_buffer_fuzzy_find<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>g", ":Telescope git_files<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>d", ":Telescope diagnostics<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>l", ":Telescope live_grep<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>b", ":Telescope buffers<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>c", ":Telescope commands<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>h", ":Telescope help_tags<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>m", ":Telescope keymaps<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>v", ":Telescope lsp_document_symbols<CR>", default_opts)
