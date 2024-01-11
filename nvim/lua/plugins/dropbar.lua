return {
  {
    "Bekaboo/dropbar.nvim",
    event = "LspAttach",
    keys = {
      {
        "<space>w",
        function()
          require("dropbar.api").pick()
        end,
        { desc = "dropbar selection" },
      },
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
            left = 0, right = 0
          }
        }
      },
      icons = {
        enable = true,
        kind = {
          use_devicons = false
        }
      },
      ui = {
        bar = {
          separator = "",
          extends = "…",
        },
        menu = {
          separator = "",
          indicator = "",
        },
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)
      vim.api.nvim_set_hl(0, "DropBarPreview", { bold = false })
      vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { bold = false })
      vim.api.nvim_set_hl(0, "DropBarHover", { bold = true })
      vim.api.nvim_set_hl(0, "DropBarCurrentContext", { bold = true })
      vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { bold = true })
    end
  },
}
