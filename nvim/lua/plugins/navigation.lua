local detail = false
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          mappings = {
            i = {
              ["<C-s>"] = require("telescope.actions").select_horizontal,
              ["<C-x>"] = false,
            },
            n = {
              ["<C-s>"] = require("telescope.actions").select_horizontal,
              ["<C-x>"] = false,
            },
          },
          preview = true,
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set({ "n" }, "<space>e", "<cmd>Telescope find_files<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>h", "<cmd>Telescope help_tags<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>b", "<cmd>Telescope buffers<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>g", "<cmd>Telescope live_grep<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>d", "<cmd>Telescope diagnostics<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>r", "<cmd>Telescope lsp_references<cr>", { noremap = true })
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
        ["."] = {
          "actions.open_cmdline",
          opts = {
            shorten_path = true,
          },
          desc = "Open vim cmdline with current entry as an argument",
        },
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["yp"] = {
          function()
            local current_dir = require("oil").get_current_dir()
            local entry = require("oil").get_cursor_entry()["name"]
            vim.fn.setreg('"', current_dir .. entry)
            vim.notify("Yank " .. current_dir .. entry)
          end,
          mode = "n",
          nowait = true,
          desc = "Yank cursor entry full path.",
        },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function(_, opts)
      require("oil").setup(opts)
      require("oil").set_columns({ "icon" })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}
