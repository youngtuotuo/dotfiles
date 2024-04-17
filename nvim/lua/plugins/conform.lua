return {
  "stevearc/conform.nvim",
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
          "--line-length=120",
        },
      },
      clang_format = {
        prepend_args = {
          "-style={BasedOnStyle: llvm, IndentWidth: 4}",
        },
      },
    },
    format_on_save = nil,
    format_after_save = nil,
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>f", require("conform").format, { noremap = true, desc = "Format buffer" })
  end,
}
