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
    signcolumn = false,
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

    local next_hunk    = function() gs.next_hunk() end
    local prev_hunk    = function() gs.prev_hunk() end
    local stage_hunk   = require("gitsigns").stage_hunk
    local reset_hunk   = require("gitsigns").reset_hunk
    local preview_hunk = require("gitsigns").preview_hunk
    local blame_line   = require("gitsigns").blame_line
    local toggle_signs = require("gitsigns").toggle_signs

    local ts_obj_status, ts_rep = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ts_obj_status then
      next_hunk, prev_hunk = ts_rep.make_repeatable_move_pair(next_hunk, prev_hunk)
    end

    local keys = {
      { "n", "gj", next_hunk,    { desc = "Gitsigns next hunk"     } },
      { "n", "gk", prev_hunk,    { desc = "Gitsigns previous hunk" } },
      { "n", "gs", stage_hunk,   { desc = "Gitsigns stage hunk"    } },
      { "n", "gr", reset_hunk,   { desc = "Gitsigns reset hunk"    } },
      { "n", "gp", preview_hunk, { desc = "Gitsigns preview hunk"  } },
      { "n", "gh", blame_line,   { desc = "Gitsigns line blame"    } },
      { "n", "<leader>g", toggle_signs,  { desc = "Gitsigns toggle sign"   } },
    }
    for _, v in ipairs(keys) do
      vim.keymap.set(unpack(v))
    end
  end,
}
