local status_ok, _ = pcall(require, "telescope")
if not status_ok then return end

local actions = require 'telescope.actions'

require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {
                height = 0.9,
                width = 0.95,
                preview_width = 0.5,
            }
        },
        color_devicons = true,
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
        emoji = {
            action = function(emoji)
                -- argument emoji is a table.
                -- {name="", value="", cagegory="", description=""}

                vim.fn.setreg("*", emoji.value)
                print([[Press p or "*p to paste this emoji]] .. emoji.value)

                -- insert emoji when picked
                -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
            end,
        }
    }
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, "emoji")
pcall(require('telescope').load_extension, "heading")
pcall(require('telescope').load_extension, "undo")

local default_opts = {noremap = true, silent = true}
-- Telescope Stuff
vim.api.nvim_set_keymap("n", "<space>a", ":lua require('telescope.builtin').builtin()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>r", ":lua require('telescope.builtin').lsp_references()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>e", ":lua require('telescope.builtin').find_files()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>f", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>g", ":lua require('telescope.builtin').git_files()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>d", ":lua require('telescope.builtin').diagnostics()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>l", ":lua require('telescope.builtin').live_grep()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>b", ":lua require('telescope.builtin').buffers()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>c", ":lua require('telescope.builtin').commands()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>h", ":lua require('telescope.builtin').help_tags()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>m", ":lua require('telescope.builtin').keymaps()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<space>v", ":lua require('telescope.builtin').lsp_document_symbols()<CR>", default_opts)
