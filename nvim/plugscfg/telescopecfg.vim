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
