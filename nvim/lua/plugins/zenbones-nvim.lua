return {
  "zenbones-theme/zenbones.nvim",
  config = function()
    vim.g.zenbones_compat = 1
    vim.cmd.colo "zenbones"
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#292929" })
  end
}
