local status_ok, _ = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require 'telescope.actions'

return {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    initial_mode = "insert",
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<S-Tab>"] = actions.move_selection_next,
        ["<Tab>"] = actions.move_selection_previous
      },
      i = {
        ["<C-c>"] = actions.close,
      }
    },
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.7,
        height = 0.7,
        mirror = false,
        scroll_speed = 5,
        preview_height = 0.4,
        preview_cutoff = 5,
        prompt_position = "top"
      }
    },
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
      '--column', '--smart-case', '-u'
    }
  },
  extensions = {
   fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = false
    }
  }
}
