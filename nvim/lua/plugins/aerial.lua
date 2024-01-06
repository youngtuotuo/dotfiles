return {
  {
    "stevearc/aerial.nvim",
    keys = {
      {
        "<space>o",
        function()
          require("aerial").toggle({ focus = true })
        end,
        { noremap = true, silent = true },
      },
    },
    config = function()
      require("aerial").setup({
        layout = {
          default_direction = "left",
          max_width = 30,
          min_width = 30,
        },
      })
    end,
  },
}
