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
    },
    formatters = {
      stylua = {
        cmd = "stylua",
        prepend_args = {
          "--indent-type=spaces",
          "--indent-width=2",
          "--column-width=100",
        },
      },
      ruff_fmt = {
        prepend_args = { "--line-length", "150" },
      },
    },
    format_on_save = nil,
    format_after_save = nil,
  },
}
