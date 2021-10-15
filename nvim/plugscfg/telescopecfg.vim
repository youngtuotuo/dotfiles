lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    initial_mode = "normal",
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
    layout_strategy="horizontal",
    layout_config = {
      horizontal = {
         width = 120,
         height = 0.8,
         preview_width = 80,
         preview_cutoff = 5,
         prompt_position = "bottom"
      }
    },
    --layout_strategy="vertical",
    --layout_config = {
    --  vertical = {
    --     width = 0.5,
    --     height = 0.8,
    --     preview_hieght = 0.6,
    --     preview_cutoff = 5,
    --     prompt_position = "top"
    --  }
    --},
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzy_native')
EOF
nnoremap <space>e :Telescope file_browser<CR>
nnoremap <space>f :Telescope find_files hidden=true<CR>
nnoremap <space>b :Telescope buffers<CR>
nnoremap <space>l :Telescope live_grep<CR>
nnoremap <space>d :Telescope lsp_workspace_diagnostics<CR>
nnoremap <space>c :Telescope commands<CR>
nnoremap <space>h :Telescope help_tags<CR>
nnoremap <space>m :Telescope keymaps<CR>
