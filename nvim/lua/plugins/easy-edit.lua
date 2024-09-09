return {
  {
    "L3MON4D3/LuaSnip",
    cond = function()
      return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
    end,
    ft = { "typst", "python", "html" },
    version = "v2.*",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })
      vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
      ls.config.set_config(opts)
      local next_node = function()
        if require("luasnip").jumpable(1) then
          require("luasnip").jump(1)
        end
      end
      local prev_node = function()
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        end
      end
      local cycle_choice = function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(1)
        end
      end
      vim.keymap.set({ "i", "s" }, "<C-n>", next_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-p>", prev_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-j>", cycle_choice, { silent = true })
    end,
  },
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
