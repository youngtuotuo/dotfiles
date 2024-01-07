return {
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>t", "<cmd>Twilight<cr>" }
    },
    config = function()
      require("twilight").setup({})
    end,
  },
}
