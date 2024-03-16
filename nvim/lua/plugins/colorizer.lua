return {
  "norcalli/nvim-colorizer.lua",
  lazy = true,
  cmd = "ColorizerToggle",
  keys = {
      { "<leader>c", "<cmd>ColorizerToggle<cr>", noremap = true, desc = "Code outline" },
  },
  -- opts = {}, -- don't use this
  config = function()
    require("colorizer").setup()
  end,
}
