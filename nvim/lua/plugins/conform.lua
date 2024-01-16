return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  -- stylua: ignore
  keys = {
    {
      "<leader>f", function() require("conform").format({ timeout_ms = 3000 }) end,
      mode = { "n", "v" }, desc = "Format buffer"
    }
  },
  init = function()
    -- use gq to format
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      go = { "gofumpt" },
      c = { "clang_format" },
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
      ruff_fmt = {
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
