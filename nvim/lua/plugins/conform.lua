return {
  "stevearc/conform.nvim",
  lazy = true,
  keys = function()
    local format = function()
      require("conform").format()
    end
    return {
      { "<leader>f", format, mode = { "n", "v" }, desc = "Format buffer" },
    }
  end,
  dependencies = {
    {
      "williamboman/mason.nvim",
    },
  },
  opts = {
    async = true,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
      json = { "jq" },
    },
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type=spaces",
          "--indent-width=2",
          "--column-width=120",
        },
      },
      ruff_fmt = {
        prepend_args = {
          "--line-length=120"
        }
      }
    },
    format_on_save = nil,
    format_after_save = nil,
  },
}
