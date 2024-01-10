return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- stylua: ignore
    keys = { { "<leader>i", "<cmd>IBLToggle<cr>" } },
    opts = {
      enabled = false,
      scope = { enabled = true, show_start = false, show_end = false },
      indent = { char = "│" },
    },
  },
}
