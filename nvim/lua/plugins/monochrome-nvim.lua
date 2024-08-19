return {
  "kdheepak/monochrome.nvim",
  config = function()
    vim.cmd.colorscheme "monochrome"
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#292929" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#292929" })
  end,
}
