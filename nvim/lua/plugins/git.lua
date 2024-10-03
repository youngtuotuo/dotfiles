return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      preview_config = {
        -- Options passed to nvim_open_win
        border = "none",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      signcolumn = false,
      numhl = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        local gs = require("gitsigns")
        next_hunk, prev_hunk = gs.next_hunk, gs.prev_hunk
        local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
        if ok then
          next_hunk, prev_hunk = ts_repeat_move.make_repeatable_move_pair(next_hunk, prev_hunk)
        end
        vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk)
        vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk)

        -- Actions
        map("n", "<leader>gs", gitsigns.stage_hunk)
        map("n", "<leader>gr", gitsigns.reset_hunk)
        map("v", "<leader>gs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>gr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>gS", gitsigns.stage_buffer)
        map("n", "<leader>gu", gitsigns.undo_stage_hunk)
        map("n", "<leader>gR", gitsigns.reset_buffer)
        map("n", "<leader>gp", gitsigns.preview_hunk)
        map("n", "<leader>gb", gitsigns.blame_line)
        map("n", "<leader>gg", gitsigns.toggle_signs)
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
