return {
  {
    "stevearc/aerial.nvim",
    -- stylua: ignore
    lazy = true,
    keys = {
      { "<space>o", function() require("aerial").toggle({ focus = true }) end, noremap = true, desc = "Code outline" },
    },
    opts = {
      layout = {
        default_direction = "left",
        max_width = 30,
        min_width = 30,
      },
    },
  },
}
