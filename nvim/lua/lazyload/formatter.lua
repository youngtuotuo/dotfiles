-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        lua = {
            function()
                return {
                    exe = "lua-format",
                    args = {'--column-limit=120'},
                    stdin = true
                }
            end
        },
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '--style="{IndentWidth: 2, AccessModifierOffset: -2}"'
                    },
                    stdin = true
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '--style="{IndentWidth: 2, AccessModifierOffset: -2}"'
                    },
                    stdin = true
                }
            end
        },
        python = {
            function()
                return
                    {exe = "black", args = {'-l 120', "-q", "-"}, stdin = true}
            end
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
local format_grp = vim.api
                       .nvim_create_augroup("FormatAutogroup", {clear = true})

vim.api.nvim_create_autocmd("BufWritePost",
                            {group = format_grp, command = "FormatWrite"})
