return {
  {
    "mhartington/formatter.nvim",
    keys = {
      { "<leader>f", ":Format" },
    },
    cmd = "Format",
    config = function()
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
            require("formatters.stylua"),
          },
          c = {
            require("formatters.clang-format"),
          },
          cpp = {
            require("formatters.clang-format"),
          },
          python = {
            require("formatters.ruff"),
          },
          go = {
            require("formatters.go"),
          },
          rust = {
            require("formatters.rustfmt"),
          },
          markdown = {
            require("formatters.prettier"),
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
    end,
  },
}
