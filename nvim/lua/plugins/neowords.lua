return {
  "backdround/neowords.nvim",
  event = { "BufRead" },
  config = function(_, _)
    local neowords = require("neowords")
    local p = neowords.pattern_presets

    local hops = neowords.get_word_hops(
      p.snake_case,
      p.camel_case,
      p.upper_case,
      p.number,
      p.hex_color
      -- "\\v\\.+",
      -- "\\v,+",
      -- "\\v\"+",
      -- "\\v'+"
    )

    -- stylua: ignore start
    vim.keymap.set({ "n", "x", "o" }, "w", hops.forward_start, { desc = "neoword forward to start" })
    vim.keymap.set({ "n", "x", "o" }, "e", hops.forward_end, { desc = "neoword forward to end" })
    vim.keymap.set({ "n", "x", "o" }, "b", hops.backward_start, { desc = "neoword backward to start" })
    vim.keymap.set({ "n", "x", "o" }, "ge", hops.backward_end, { desc = "neoword backward to end" })
    local ts_obj_status, ts_rep_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ts_obj_status then
      local forward_start, backward_start = ts_rep_move.make_repeatable_move_pair(
        hops.forward_start, hops.backward_start
      )
      local forward_end, backward_end = ts_rep_move.make_repeatable_move_pair(
        hops.forward_end, hops.backward_end
      )
      vim.keymap.set({ "n", "x", "o" }, "w", forward_start, { buffer = 0, desc = "Gitsigns next hunk" })
      vim.keymap.set({ "n", "x", "o" }, "e", forward_end, { buffer = 0, desc = "Gitsigns previous hunk" })
      vim.keymap.set({ "n", "x", "o" }, "b", backward_start, { buffer = 0, desc = "Gitsigns previous hunk" })
      vim.keymap.set({ "n", "x", "o" }, "ge", backward_end, { buffer = 0, desc = "Gitsigns previous hunk" })
    end
  end,
}
