local function tele_git()
  if not pcall(require("telescope.builtin").git_files) then
    vim.notify("[Telescope git_files] Not a git repository", 3)
  end
end

local function tele_git_commit()
  if not pcall(require("telescope.builtin").git_bcommits) then
    vim.notify("[Telescop git_bcommits] Not a git repository", 3)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      vim.api.nvim_create_user_command("T", "Telescope", {})
    end,
    -- stylua: ignore
    keys = {
      { "<space>e", "<cmd>Telescope fd<cr>", desc = "Telescope fd" },
      { "<space>g", tele_git, desc = "Telescope git_files" },
      { "<space>c", tele_git_commit, desc = "Telescope git_bcommits" },
      { "<space>l", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
    },
    version = false,
    opts = function()
      local actions = require("telescope.actions")
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
          layout_config = {
            horizontal = {
              height = 0.95,
              preview_cutoff = 120,
              prompt_position = "bottom",
              preview_width = 0.65,
              width = 0.95
            },
          },
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
        enabled = vim.fn.executable("make") == 1 or vim.fn.executable("mingw32-make"),
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
  },
  {
    "crispgm/telescope-heading.nvim",
    ft = { "markdown" },
    keys = { { "<space>h", "<cmd>Telescope heading<cr>", desc = "telescope heading" } },
    config = function()
      require("telescope").load_extension("heading")
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    event = "BufRead",
    keys = { { "<space>u", "<cmd>Telescope undo<cr>", desc = "telescope undo (C-R/C-CR) for select" } },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
}
