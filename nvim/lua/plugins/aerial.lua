return {
  {
    "stevearc/aerial.nvim",
    -- stylua: ignore
    keys = {
      { "<space>o", function() require("aerial").toggle({ focus = true }) end, { noremap = true, silent = true } },
    },
    opt = {
      layout = {
        default_direction = "left",
        max_width = 30,
        min_width = 30,
      },
    },
  },
}
