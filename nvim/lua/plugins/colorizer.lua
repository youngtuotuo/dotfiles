return {
  "norcalli/nvim-colorizer.lua",
  init = function()
    vim.opt.termguicolors = true
  end,
  config = function()
    require 'colorizer'.setup()
  end
}
