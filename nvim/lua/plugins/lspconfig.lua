return {
  "neovim/nvim-lspconfig",
  init = function()
    vim.api.nvim_create_user_command("LI", "LspInfo", {})
  end,
  cmd = { "LspInfo" },
  ft = _G.lspfts,
  dependencies = {
    {
      "folke/neodev.nvim",
      cond = function()
        return vim.fn.getcwd() == os.getenv(_G.home) .. "/github/dotfiles"
      end,
      opts = {
        library = {
          -- disalbe this to avoid double lsp reference
          runtime = true,
        },
      },
    },
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      init = function()
        vim.api.nvim_create_user_command("M", "Mason", {})
      end,
      opts = {
        ui = { border = _G.border },
        ensure_installed = {
          "clang-format",
          "clangd",
          "gofumpt",
          "gopls",
          "lua_ls",
          "markdownlint",
          "prettier",
          "pyright",
          "ruff",
          "ruff_lsp",
          "stylua",
          "rust_analyzer",
          "zls"
        },
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = require("language_servers.lua_ls"),
          ["pyright"] = require("language_servers.pyright"),
          ["ruff_lsp"] = require("language_servers.ruff_lsp"),
          -- not setup yet
          -- ["texlab"] = require("language_servers.texlab"),
        },
      },
    },
  },
  config = function(_, _)
    -- LspInfo command
    require("lspconfig.ui.windows").default_options.border = _G.border
    -- all server agnostic settings
    require("language_servers.format")
    require("language_servers.capabilities")
    require("language_servers.keymaps")
    require("language_servers.diagnostics")
    require("language_servers.handlers")
    require("language_servers.floatwin")
  end,
}
