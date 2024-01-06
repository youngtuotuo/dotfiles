return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
        { "<space>a", "<cmd>Telescope builtins<cr>" },
        { "<space>r", "<cmd>Telescope lsp_references<cr>" },
        { "<space>e", "<cmd>Telescop find_files<cr>" },
        { "<space>f", "<cmd>Telescop current_buffer_fuzzy_find<cr>" },
        { "<space>g", "<cmd>Telescop git_files<cr>" },
        { "<space>d", "<cmd>Telescop diagnostics severity_bound=0<cr>" },
        { "<space>l", "<cmd>Telescop live_grep<cr>" },
        { "<space>b", "<cmd>Telescop buffers<cr>" },
        { "<space>v", "<cmd>Telescop lsp_document_symbols<cr>" },
    },
    tag = "0.1.5",
    config = function()
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
          color_devicons = false,
          selection_caret = "❯ ",
          entry_prefix = "  ",
          preview = {
            treesitter = false,
          },
          prompt_prefix = ">_ ",
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
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "crispgm/telescope-heading.nvim",
        keys = { {"<space>3", "<cmd>Telescope heading<cr>" } },
        config = function()
          require("telescope").load_extension("heading")
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<space>u", "<cmd>Telescope undo<cr>" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
  },
}
