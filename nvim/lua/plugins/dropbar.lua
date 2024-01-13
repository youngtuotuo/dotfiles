return {
  "Bekaboo/dropbar.nvim",
  event = { "LspAttach" },
  init = function()
    vim.api.nvim_create_user_command("DR", function()
      if vim.o.winbar == "" then
        vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
      else
        vim.o.winbar = ""
      end
    end, {})
  end,
  -- stylua: ignore
  keys = {
    { "<space>w", function() require("dropbar.api").pick() end, { desc = "dropbar selection" } },
  },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = {
    menu = {
      preview = false,
      win_configs = {
        border = BORDER,
      },
      entry = {
        padding = {
          left = 1,
          right = 0,
        },
      },
    },
    icons = {
      enable = true,
      kinds = {
        use_devicons = false,
      },
      ui = {
        bar = {
          separator = " ",
          extends = "…",
        },
        menu = {
          separator = "",
          indicator = "",
        },
      },
    },
  },
}
