local status_ok, _ = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        height = 0.9,
        width = 0.95,
        preview_width = 0.5,
      },
    },
    color_devicons = true,
    prompt_prefix = "> ",
    selection_caret = " ",
    path_display = { "smart" },
    initial_mode = "insert",
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
      },
      i = {
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-u",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "heading")
pcall(require("telescope").load_extension, "undo")
