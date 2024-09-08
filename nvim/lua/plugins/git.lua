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
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

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
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
