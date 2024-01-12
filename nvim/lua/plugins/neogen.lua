return {
  "danymat/neogen",
  lazy = true,
  cmd = "Neogen",
  init = function()
    vim.api.nvim_create_user_command("NG", "Neogen", {})
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  opts = { snippet_engine = "luasnip" },
  version = "*",
}
