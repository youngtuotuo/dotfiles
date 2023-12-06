-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
-- Utilities for creating configurations

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    lua = {
      require("lazyload.formatters.stylua"),
    },
    c = {
      require("lazyload.formatters.clang-format"),
    },
    cpp = {
      require("lazyload.formatters.clang-format"),
    },
    python = {
      require("lazyload.formatters.ruff"),
    },
    go = {
      require("lazyload.formatters.go"),
    },
    rust = {
      require("lazyload.formatters.rustfmt"),
    },
    markdown = {
      require("lazyload.formatters.prettier"),
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})
vim.keymap.set("n", "<leader>f", ":Format ", { noremap = true })
