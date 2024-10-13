local check_git_repo = function()
  local output = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
  return #output ~= 0
end
return {
  {
    "lewis6991/gitsigns.nvim",
    cond = check_git_repo,
    opts = {
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      signcolumn = false,
      numhl = true,
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        vim.keymap.set({ "n", "x", "o" }, "]c", gs.next_hunk)
        vim.keymap.set({ "n", "x", "o" }, "[c", gs.prev_hunk)

        vim.keymap.set({ "n" }, "<leader>gs", gs.stage_hunk)
        vim.keymap.set({ "n" }, "<leader>gr", gs.reset_hunk)
        vim.keymap.set({ "v" }, "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set({ "v" }, "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set({ "n" }, "<leader>gS", gs.stage_buffer)
        vim.keymap.set({ "n" }, "<leader>gu", gs.undo_stage_hunk)
        vim.keymap.set({ "n" }, "<leader>gR", gs.reset_buffer)
        vim.keymap.set({ "n" }, "<leader>gp", gs.preview_hunk)
        vim.keymap.set({ "n" }, "<leader>gb", gs.blame_line)
        vim.keymap.set({ "n" }, "<leader>gg", gs.toggle_numhl)
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cond = check_git_repo,
    cmd = { "G", "Git" },
  },
}
