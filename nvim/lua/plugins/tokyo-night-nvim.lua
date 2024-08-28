return {
  "folke/tokyonight.nvim",
  opts = {
    style = "storm",
    terminal_colors = false,
    transparent = false,
    styles = {
      comments = {},
      keywords = {},
    },
    plugins = {
      all = false,
      illuminate = true,
    },
    on_highlights = function(hl, c)
      local prompt = "#2d3149"
      hl.WinSeparator = {
        fg = c.fg_dark,
      }
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = prompt,
      }
      hl.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colo("tokyonight")
  end,
}
