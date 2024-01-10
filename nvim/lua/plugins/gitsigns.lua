return {
  {
    "lewis6991/gitsigns.nvim",
    -- stylua: ignore
    keys = {
      { "]c",         function() require("gitsigns").next_hunk() end, { buffer = 0 }},
      { "[c",         function() require("gitsigns").prev_hunk() end, { buffer = 0 }},
      { "<leader>gs", function() require("gitsigns").stage_hunk() end, { buffer = 0 }},
      { "<leader>gs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = 0 }, mode = "v"},
      { "<leader>gr", function() require("gitsigns").reset_hunk() end, { buffer = 0 }},
      { "<leader>gr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = 0 }, mode = "v"},
      { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, { buffer = 0 }},
      { "<leader>gp", function() require("gitsigns").preview_hunk() end, { buffer = 0 }},
      { "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { buffer = 0 }},
      { "<leader>gd", function() require("gitsigns").diffthis() end, { buffer = 0 }},
      { "<leader>gt", function() require("gitsigns").toggle_deleted() end, { buffer = 0 }},
      { "<leader>gl", function() require("gitsigns").toggle_signs() end, { buffer = 0 }},
    },
    opt = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = BORDER,
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
    },
    config = function(_, opts)
      -- example: make gitsigns.nvim movement repeatable with ; and , keys.
      local gs = require("gitsigns")
      gs.setup(opts)
      local ts_obj_status, ts_rep_move =
        pcall(require, "nvim-treesitter.textobjects.repeatable_move")

      -- make sure forward function comes first
      if ts_obj_status then
        local next_hunk_repeat, prev_hunk_repeat =
          ts_rep_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
        -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

        vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat)
        vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat)
      end
    end,
  },
}
