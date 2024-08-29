return {
  "OXY2DEV/markview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    modes = { "n", "c", "no" },
    hybrid_modes = { "n", "i" },
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = "c"
      end,
    },
  },
  config = function(_, opts)
    require("markview").setup(opts)
  end
}
