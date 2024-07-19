return {
  "christoomey/vim-tmux-navigator",
  config = function()
    vim.keymap.set({ "n" },  "<C-h>", "<cmd>TmuxNavigateLeft<cr>" , { nowait = true, noremap = true })
    vim.keymap.set({ "n" },  "<C-j>", "<cmd>TmuxNavigateDown<cr>" , { nowait = true, noremap = true })
    vim.keymap.set({ "n" },  "<C-k>", "<cmd>TmuxNavigateUp<cr>" , { nowait = true, noremap = true })
    vim.keymap.set({ "n" },  "<C-l>", "<cmd>TmuxNavigateRight<cr>" , { nowait = true, noremap = true })
    vim.keymap.set({ "n" },  "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>" , { nowait = true, noremap = true })
  end
}
