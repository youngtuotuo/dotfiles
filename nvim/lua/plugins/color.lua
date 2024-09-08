local has_256_colors = string.find(vim.api.nvim_list_uis()[1].term_name, "256")
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
    "rebelot/kanagawa.nvim",
    lazy = not has_256_colors,
    opts = {
      terminalColors = false,
    },
    config = function(_, opts)
      vim.cmd.colo("kanagawa-wave")
    end,
  },
  {
    "jacoborus/tender.vim",
    lazy = has_256_colors,
    config = function()
      vim.cmd.color("tender")
    end,
  },
}
