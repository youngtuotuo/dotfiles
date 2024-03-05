return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  priority = 1000,
  opts = {
    undercurl = false,
    transparent = true,
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    terminalColors = false,
    theme = "dargon",
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colo "kanagawa-dragon"
  end
}
