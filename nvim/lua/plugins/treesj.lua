return {
  "Wansmer/treesj",
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  keys = {
    { "<space>j", "<cmd>TSJToggle", desc = "TSJToggle" }
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
}
