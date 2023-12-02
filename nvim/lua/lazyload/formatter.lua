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
      function()
        return require("lazyload.formatters.stylua")
      end,
    },
    c = {
      function()
        return require("lazyload.formatters.clang-format")
      end,
    },
    cpp = {
      function()
        return require("lazyload.formatters.clang-format")
      end,
    },
    python = {
      function()
        return require("lazyload.formatters.black")
      end,
      function()
        return require("lazyload.formatters.ruff")
      end,
    },
    go = {
      function()
        return require("lazyload.formatters.go")
      end,
    },
    rust = {
      function()
        return require("lazyload.formatters.rustfmt")
      end,
    },
    markdown = {
      function()
        return require("lazyload.formatters.prettier")
      end,
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
