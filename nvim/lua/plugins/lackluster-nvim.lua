-- example lazy.nvim install setup
return {
  "slugbyte/lackluster.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("lackluster")
    -- vim.cmd.colorscheme("lackluster-hack")
    -- vim.cmd.colorscheme("lackluster-mint")
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "LazyNormal", { bg = "none" })
  end,
}
