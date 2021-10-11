lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    initial_mode = "insert",
    mappings = {
      n = {
        ["q"] = actions.close,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
    layout_strategy="vertical",
    layout_config = {
      vertical = {
         width = 0.5,
         height = 0.6,
         preview_hieght = 0.5,
         preview_cutoff = 5,
         prompt_position = "top"
      }
    },
  },
--require('telescope').load_extension('fzf_native')
}
EOF
nnoremap <space>e :Telescope file_browser<CR>
nnoremap <space>f :Telescope find_files<CR>
nnoremap <space>b :Telescope buffers<CR>
nnoremap <space>l :Telescope live_grep<CR>
nnoremap <space>d :Telescope lsp_workspace_diagnostics<CR>
nnoremap <space>c :Telescope commands<CR>
nnoremap <space>h :Telescope help_tags<CR>
nnoremap <space>m :Telescope keymaps<CR>
