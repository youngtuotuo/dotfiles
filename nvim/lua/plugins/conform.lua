return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  -- stylua: ignore
  keys = function()
    local format = function()
      require("conform").format({ timeout_ms = 3000 })
    end
    return {
      { "<leader>f", format, mode = { "n", "v" }, desc = "Format buffer" }
    }
  end,
  init = function()
    -- use gq to format
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_format" },
      go = { "gofumpt" },
      c = { "clang_format" },
      zig = { "zigfmt" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      json = { "jq" }
    },
    formatters = {
      stylua = {
        cmd = "stylua",
        prepend_args = {
          "--indent-type=spaces",
          "--indent-width=2",
          "--column-width=150",
        },
      },
      ruff_format = {
        prepend_args = { "--line-length", "150" },
      },
      clang_format = {
        prepend_args = {
          '-style={BasedOnStyle: llvm, ColumnLimit: 150, IndentWidth: 4, AccessModifierOffset: -4, IndentCaseLabels: true, AlignOperands: AlignAfterOperator, PointerAlignment: Right}',
        },
      },
    },
    format_on_save = nil,
    format_after_save = nil,
  },
}
