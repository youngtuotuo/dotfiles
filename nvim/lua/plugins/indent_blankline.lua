return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  cmd = "IBLToggle",
  init = function()
    vim.api.nvim_create_user_command("IB", "IBLToggle", {})
  end,
  opts = {
    enabled = false,
    scope = { enabled = true, show_start = false, show_end = false },
    indent = { char = "│" },
  },
}
