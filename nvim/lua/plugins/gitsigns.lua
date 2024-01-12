return {
  "lewis6991/gitsigns.nvim",
  cond = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= "",
  event = { "BufRead" },
  opts = {
    -- stylua: ignore
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = { interval = 1000, follow_files = true },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 300,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = BORDER,
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = { enable = false },
  },
  -- stylua: ignore
  config = function(_, opts)
    local gs = require("gitsigns")
    gs.setup(opts)

    vim.keymap.set("n", "]c",         function() require("gitsigns").next_hunk() end,  { buffer = 0, desc = "Gitsigns next hunk" })
    vim.keymap.set("n", "[c",         function() require("gitsigns").prev_hunk() end,  { buffer = 0, desc = "Gitsigns previous hunk" })
    vim.keymap.set("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { buffer = 0, desc = "Gitsigns stage hunk" })
    vim.keymap.set("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { buffer = 0, desc = "Gitsigns reset hunk" })
    vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { buffer = 0, desc = "Gitsigns preview hunk" })

    local ts_obj_status, ts_rep_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ts_obj_status then
      local next_hunk_repeat, prev_hunk_repeat = ts_rep_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
      vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat, { buffer = 0, desc = "Gitsigns next hunk" })
      vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat, { buffer = 0, desc = "Gitsigns previous hunk" })
    end
  end,
}
