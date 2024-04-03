return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall" },
    ft = { "json", "python", "sh", "lua" },
    build = ":MasonInstall jq ruff shtfmt stylua",
    init = function()
      vim.api.nvim_create_user_command("M", "Mason", {})
    end,
    opts = {
      ui = { border = _G.border, width = 0.5, height = 0.5 },
    },
  },
}
