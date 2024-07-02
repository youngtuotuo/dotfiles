return {
  "zootedb0t/citruszest.nvim",
  opts = {
    option = {
      transparent = true, -- Enable/Disable transparency
      bold = false,
      italic = false,
    },
  },
  config = function(_, opts)
    require("citruszest").setup(opts)
    -- vim.cmd.colo([[citruszest]])
  end,
}
