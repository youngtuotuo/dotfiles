return {
  "oxfist/night-owl.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    italics = false,
    underline = false,
  },
  config = function(_, opts)
    -- load the colorscheme here
    require("night-owl").setup()
    vim.cmd.colorscheme("night-owl")
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#021020" })
  end,
}
