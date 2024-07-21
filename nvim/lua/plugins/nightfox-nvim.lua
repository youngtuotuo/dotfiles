return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      transparent = true,
      terminal_colors = false,
      module_default = true,
    },
    styles = {
      keywords = "bold",
    }
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd.colo("nightfox")
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
