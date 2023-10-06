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
      vertical = {
        height = 0.9,
        width = 0.8,
        preview_height = 0.7,
        scroll_speed = 5,
      },
    },
    results_title = "Results",
    sorting_strategy = "ascending",
    dynamic_preview_title = true,
    color_devicons = true,
    selection_caret = " ❯ ",
    entry_prefix = "  ",
    preview = {
      treesitter = false,
    },
    prompt_prefix = "  ",
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

local keymap = vim.keymap.set
keymap("n", "<space>a", require("telescope.builtin").builtin)
keymap("n", "<space>r", require("telescope.builtin").lsp_references)
keymap("n", "<space>e", require("telescope.builtin").find_files)
keymap("n", "<space>f", require("telescope.builtin").current_buffer_fuzzy_find)
keymap("n", "<space>g", require("telescope.builtin").git_files)
keymap("n", "<space>d", require("telescope.builtin").diagnostics)
keymap("n", "<space>l", require("telescope.builtin").live_grep)
keymap("n", "<space>b", require("telescope.builtin").buffers)
keymap("n", "<space>v", require("telescope.builtin").lsp_document_symbols)
keymap("n", "<space>u", require("telescope").extensions.undo.undo)
keymap("n", "<space>3", require("telescope").extensions.heading.heading)
