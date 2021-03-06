local actions = require'telescope.actions'
require('telescope').setup{
  defaults = {
    initial_mode = "insert",
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      }, 
      i = {
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
      },
    },
    layout_strategy="vertical",
    layout_config = {
      vertical = {
        width = 0.7,
        height = 0.7,
        mirror = false,
        scroll_speed = 5,
        preview_height = 0.4,
        preview_cutoff = 5,
        prompt_position = "top"
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
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      }
    }
  }
  require('telescope').load_extension('fzy_native')
