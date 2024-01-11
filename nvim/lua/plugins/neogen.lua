return {
  {
    "danymat/neogen",
    lazy = true,
    cmd = "Neogen",
    init = function()
      vim.api.nvim_create_user_command("Ng", "Neogen", {})
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { snippet_engine = "luasnip" },
    version = "*"
  },
}
