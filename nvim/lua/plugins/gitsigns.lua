return {

  "lewis6991/gitsigns.nvim",
  cond = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= "",
  event = { "BufRead" },
  opts = {
    -- stylua: ignore
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "-" },
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
      border = _G.border,
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

    local ts_obj_status, ts_rep = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    local next_hunk = function() gs.next_hunk(); vim.cmd[[norm zz]] end
    local prev_hunk = function() gs.prev_hunk(); vim.cmd[[norm zz]] end
    if ts_obj_status then
      next_hunk, prev_hunk = ts_rep.make_repeatable_move_pair(next_hunk, prev_hunk)
    end

    local keyms = {
      { "n", "gj", function() next_hunk() end,                              { desc = "Gitsigns next hunk" } },
      { "n", "gk", function() prev_hunk() end,                              { desc = "Gitsigns previous hunk" } },
      { "n", "gs", function() require("gitsigns").stage_hunk() end,         { desc = "Gitsigns stage hunk" } },
      { "n", "gr", function() require("gitsigns").reset_hunk() end,         { desc = "Gitsigns reset hunk" } },
      { "n", "gp", function() require("gitsigns").preview_hunk() end,       { desc = "Gitsigns preview hunk" } },
      { "n", "gv", function() require("gitsigns").blame_line() end,         { desc = "Gitsigns line blame" } },
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
  end,
}
