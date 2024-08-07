return {
  "stevearc/conform.nvim",
  ft = { "json", "python", "sh", "lua", "c", "cpp", "cuda", "zig" },
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
      yaml = { "prettier" },
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
          "--line-length=150",
          "--target-version=py311",
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
