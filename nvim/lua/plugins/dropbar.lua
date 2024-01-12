local toggle_bar = function()
  if vim.o.winbar == "" then
    vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
  else
    vim.o.winbar = ""
  end
end
return {
  {
    "Bekaboo/dropbar.nvim",
    event = "LspAttach",
    init = function()
      vim.api.nvim_create_user_command("Dr", toggle_bar, {})
    end,
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
        update_events = {
          win = {
            "CursorMoved",
            "CursorMovedI",
            "WinEnter",
          },
          buf = {
            "BufModifiedSet",
            "FileChangedShellPost",
            "TextChanged",
            "TextChangedI",
          },
          global = {
            "DirChanged",
            "VimResized",
          },
        },
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
      vim.api.nvim_set_hl(0, "DropBarPreview", { bold = true })
      vim.api.nvim_set_hl(0, "DropBarHover", { fg = "NvimLightCyan", bold = true })
      vim.api.nvim_set_hl(0, "DropBarCurrentContext", { bold = true })
      vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { fg = "NvimLightCyan", bold = true })
      vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { fg = "NvimLightYellow", bold = false })
    end,
  },
}
