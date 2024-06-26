return {
  "stevearc/aerial.nvim",
  lazy = true,
  keys = function()
    local toggle = function()
      require("aerial").toggle({ focus = true })
    end
    return {
      { "<space>o", toggle, noremap = true, desc = "Code outline" },
    }
  end,
  opts = {
    layout = {
      default_direction = "left",
      max_width = 30,
      min_width = 30,
    },
  },
}
