local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  wf._watchfunc = function()
    return function() end
  end
end
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
        return vim.fn.getcwd() == os.getenv(_G.home) .. string.format("%sgithub%sdotfiles", _G.sep, _G.sep)
      end,
      opts = {
        library = {
          runtime = true,
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      },
    },
    {
      "williamboman/mason.nvim",
      cmd = { "Mason" },
      init = function()
        vim.api.nvim_create_user_command("M", "Mason", {})
      end,
      opts = {
        ui = { border = _G.border },
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
          ["texlab"] = require("language_servers.texlab"),
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function()
        local ensure_installed = {
          "clang-format",
          "clangd",
          "debugpy",
          "gopls",
          "jq",
          "lua_ls",
          "pyright",
          "ruff",
          "ruff_lsp",
          "rust_analyzer",
          "shfmt",
          "stylua",
          "texlab",
          "zls",
          "codelldb",
        }
        return {
          ensure_installed = ensure_installed,
        }
      end,
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
