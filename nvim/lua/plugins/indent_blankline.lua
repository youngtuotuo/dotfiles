return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function()
      require("ibl").setup({
        enabled = false,
        scope = { enabled = true, show_start = false, show_end = false },
        indent = { char = "│" },
      })
      vim.keymap.set("n", "<leader>i", "<cmd>IBLToggle<cr>")
    end,
  },
}
