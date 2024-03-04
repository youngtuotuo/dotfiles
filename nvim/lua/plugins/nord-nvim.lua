return {
  "gbprod/nord.nvim",
  priority = 1000,
  opts = {
    transparent = true,
    erminal_colors = false,
    styles = {
      comments = { italic = false },
    },
  },
  config = function(_, opts)
    require("nord").setup(opts)
    -- vim.cmd.colorscheme("nord")
  end
}
