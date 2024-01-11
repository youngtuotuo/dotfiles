return {
  {
    {
      "neovim/nvim-lspconfig",
      cmd = { "LspInfo" },
      ft = { "lua", "c", "cpp", "python" },
      dependencies = {
        { "folke/neodev.nvim", opts = {} },
        {
          "williamboman/mason.nvim",
          cmd = "Mason",
          opts = {
            ui = { border = BORDER, height = 0.8 },
          },
          config = function(_, opts)
            require("mason").setup(opts)
          end
        },
        {
          "williamboman/mason-lspconfig.nvim",
          opts = {
            handlers = {
              function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({})
              end,
              ["clangd"] = require("language_servers.clangd"),
              ["lua_ls"] = require("language_servers.lua_ls"),
              ["pyright"] = require("language_servers.pyright"),
              ["ruff_lsp"] = require("language_servers.ruff_lsp"),
              -- not setup yet
              -- ["texlab"] = require("language_servers.texlab"),
            },
          },
        },
      },
      config = function(_, opts)
        -- LspInfo command
        require("lspconfig.ui.windows").default_options.border = BORDER

        -- all server agnostic settings
        require("language_servers.format")
        require("language_servers.capabilities")
        require("language_servers.keymaps")
        require("language_servers.diagnostics")
        require("language_servers.handlers")
      end,
    },
  },
}
