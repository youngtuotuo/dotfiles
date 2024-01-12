return {
  "folke/twilight.nvim",
  lazy = true,
  cmd = "Twilight",
  init = function()
    vim.api.nvim_create_user_command("TW", "Twilight", {})
  end,
  opts = {},
}
