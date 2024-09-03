return {
  "norcalli/nvim-colorizer.lua",
  lazy = (vim.opt.termguicolors._value ~= true),
  config = function()
    require("colorizer").setup()
  end,
}
