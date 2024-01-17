return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      vim.api.nvim_create_user_command("T", "Telescope", {})
    end,
  -- stylua: ignore
  keys = {
    { "<space>e", "<cmd>Telescop find_files<cr>" },
    { "<space>g", "<cmd>Telescop git_files<cr>" },
    { "<space>l", "<cmd>Telescop live_grep<cr>" },
    { "<space>b", "<cmd>Telescop buffers<cr>" },
  },
    version = false,
    opts = function()
      local actions = require("telescope.actions")
    -- stylua: ignore
    local maps = {
      n = {
        ["q"]       = actions.close,
        ["<C-c>"]   = actions.close,
        ["<Tab>"]   = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<C-p>"]   = actions.move_selection_previous,
        ["<C-n>"]   = actions.move_selection_next,
      },
      i = {
        ["<C-c>"]   = actions.close,
        ["<Tab>"]   = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
    }

      return {
        defaults = {
          winblend = vim.o.winblend,
          results_title = "Results",
          dynamic_preview_title = true,
          color_devicons = false,
          preview = {
            treesitter = true,
          },
          path_display = { "smart" },
          mappings = maps,
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
  },
  {
    "crispgm/telescope-heading.nvim",
    ft = { "markdown" },
    keys = { { "<space>h", "<cmd>Telescope heading<cr>" } },
    config = function()
      require("telescope").load_extension("heading")
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    event = "BufRead",
    keys = { { "<space>u", "<cmd>Telescope undo<cr>" } },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
}
