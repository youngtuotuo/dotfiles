return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = {
      { "<leader>i", "<cmd>IBLToggle<cr>" }
    },
    config = function()
      require("ibl").setup({
        enabled = false,
        scope = { enabled = true, show_start = false, show_end = false },
        indent = { char = "│" },
      })
    end,
  },
}
