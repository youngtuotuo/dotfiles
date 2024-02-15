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
      p.hex_color,
      [[\v\=+]],
      [[\v\(+]],
      [[\v\{+]],
      [[\v\[+]],
      [[\v"+]],
      [[\v'+]],
      [[\v`+]],
      [[\v,+]]
    )

    local forward_start, forward_end = hops.forward_start, hops.forward_end
    local backward_start, backward_end = hops.backward_start, hops.backward_end
    local ts_obj_status, ts_repm = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ts_obj_status then
      forward_start, backward_start = ts_repm.make_repeatable_move_pair(
        hops.forward_start, hops.backward_start
      )
      forward_end, backward_end = ts_repm.make_repeatable_move_pair(
        hops.forward_end, hops.backward_end
      )
    end

    -- stylua: ignore start
    local keyms = {
      { { "n", "x", "o" }, "w",  forward_start,  { desc = "neoword forward to start" } },
      { { "n", "x", "o" }, "e",  forward_end,    { desc = "neoword forward to end" } },
      { { "n", "x", "o" }, "b",  backward_start, { desc = "neoword backward to start" } },
      { { "n", "x", "o" }, "ge", backward_end,   { desc = "neoword backward to end" } },
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
  end,
}
