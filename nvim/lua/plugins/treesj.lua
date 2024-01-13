return {
  "Wansmer/treesj",
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  init = function()
    vim.api.nvim_create_user_command("TSJ", "TSJToggle", {})
  end,
  keys = {
    { "<space>j", "<cmd>TSJToggle<cr>", desc = "TSJToggle" }
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
}
