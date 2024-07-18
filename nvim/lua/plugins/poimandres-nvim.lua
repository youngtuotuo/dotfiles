return {
  "olivercederborg/poimandres.nvim",
  opts = {
    disable_background = true,
    disable_float_background = true,
  },
  config = function(_, opts)
    require('poimandres').setup(opts)
    vim.cmd("colorscheme poimandres")
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Label" })
  end,
}
