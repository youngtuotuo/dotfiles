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
        -- fk u MS
        return vim.fn.getcwd() == os.getenv(_G.home)
          .. string.format("%sgithub%sdotfiles", _G.sep, _G.sep)
      end,
      opts = {
        library = {
          runtime = true,
          plugins = { "nvim-dap-ui" },
          types = true
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
          "lua-language-serve",
          "markdownlint",
          "prettier",
          "pyright",
          "ruff",
          "ruff-lsp",
          "rust-analyzer",
          "stylua",
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
    for _, m in ipairs({
      "format",
      "capabilities",
      "keymaps",
      "diagnostics",
      "handlers",
      "floatwin",
    }) do
      require(string.format("language_servers.%s", m))
    end
  end,
}
