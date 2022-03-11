lua << EOF
local actions = require'telescope.actions'
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
      layout_strategy="vertical",
      layout_config = {
       vertical = {
           width = 0.999,
           height = 0.9,
           mirror = false,
           scroll_speed = 5,
           preview_height = 0.45,
           preview_cutoff = 5,
           prompt_position = "bottom"
       },
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '-u'
      },
      --layout_strategy="horizontal",
      --layout_config = {
      --  horizontal = {
      --     width = 0.9,
      --     height = 0.9,
      --     preview_width = 0.55,
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
nnoremap <space>f :Telescope find_files hidden=true<CR>
nnoremap <space>b :Telescope buffers<CR>
nnoremap <space>g :Telescope git_files<CR>
nnoremap <space>l :Telescope live_grep<CR>
nnoremap <space>d :Telescope diagnostics<CR>
nnoremap <space>c :Telescope commands<CR>
nnoremap <space>h :Telescope help_tags<CR>
nnoremap <space>m :Telescope keymaps<CR>
nnoremap <space>t :TodoTelescope cwd=
nnoremap <space>v :Telescope lsp_document_symbols<CR>
nnoremap <space>ww :Telescope lsp_workspace_symbols query=
nnoremap <space>r :Telescope lsp_references<CR>
