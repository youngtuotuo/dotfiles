return {
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({ "x" }, "ga", "<Plug>(EasyAlign)")
      vim.keymap.set({ "n" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
  {
    "chrisgrieser/nvim-spider",
    opts = {},
    config = function(_, opts)
      require("spider").setup(opts)
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    ft = { "yaml", "json", "python", "sh", "lua", "c", "cpp", "cuda" },
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
        html = { "prettier" },
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
            "-style={BasedOnStyle: llvm, IndentWidth: 4, ColumnLimit: 120}",
          },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set({ "n", "v" }, "<leader>f", require("conform").format, { noremap = true, desc = "Format buffer" })
    end,
  },
}
