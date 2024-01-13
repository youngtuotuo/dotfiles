return {
  "Bekaboo/dropbar.nvim",
  event = { "LspAttach" },
  -- stylua: ignore
  keys = {
    { "<space>w", function() require("dropbar.api").pick() end, { desc = "dropbar selection" } },
  },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = {
    general = {
      attach_events = {},
    },
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
  config = function(_, opts)
    require("dropbar").setup(opts)
  end
}
