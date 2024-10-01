local has_256_colors = (string.find(vim.api.nvim_list_uis()[1].term_name, "xterm%-256color") ~= nil)
  or (string.find(vim.api.nvim_list_uis()[1].term_name, "tmux%-256color") ~= nil)
  or (string.find(vim.api.nvim_list_uis()[1].term_name, "screen%-256color") ~= nil)
  or (string.find(vim.api.nvim_list_uis()[1].term_name, "alacritty") ~= nil)
  or (vim.fn.has("win32") == 1)
return {
  {
    "norcalli/nvim-colorizer.lua",
    lazy = not has_256_colors,
    config = function()
      vim.opt.termguicolors = true
      require("colorizer").setup()
    end,
  },
  {
    "jacoborus/tender.vim",
    config = function()
      vim.cmd.color("tender")
    end,
  },
}
