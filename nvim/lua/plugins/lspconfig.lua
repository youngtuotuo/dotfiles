local ok, wf = pcall(require, "vim.lsp._watchfiles")
wf._watchfunc = function()
  return function() end
end

-- diagnostic
local diag_config = {
  virtual_text = {
    source = true,
  },
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    header = "",
    prefix = "",
    focusable = true,
    title = " σ`∀´)σ ",
    border = _G.border,
    source = true,
  },
}

vim.diagnostic.config(diag_config)

-- float win
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = _G.border
  opts.max_width = _G.floatw
  opts.max_height = _G.floath
  opts.wrap = _G.floatwrap
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- customize hover when pressing K
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _G.border,
  title = " |･ω･) ? ",
  zindex = 500,
  focusable = true,
  max_width = 100,
})
-- customize signature help when pressing gs
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _G.border,
  title = " (・・ ) ? ",
  max_width = _G.floatw,
})

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
      -- Auto config intalled for us
      "williamboman/mason-lspconfig.nvim",
      opts = {
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = require("language_servers.lua_ls"),
          ["pyright"] = require("language_servers.pyright"),
        },
      },
    },
    {
      -- Better installer than default
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function()
        local ensure_installed = {
          -- lsp
          "clangd",
          "gopls",
          "lua_ls",
          "rust_analyzer",
          -- "pyright",
          "zls",
          -- debugger
          "codelldb",
          "debugpy",
          -- formatter
          "clang-format",
          "jq",
          "ruff",
          "shfmt",
          "stylua",
        }
        return {
          ensure_installed = ensure_installed,
        }
      end,
    },
  },
  config = function(_, _)
    -- capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
    -- for clangd
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require("lspconfig.util").default_config.capabilities = capabilities

    -- disable all format, use conform with mason
    local format = {
      formatting_options = nil,
      timeout_ms = nil,
    }
    require("lspconfig.util").default_config.format = format

    -- LspInfo command
    require("lspconfig.ui.windows").default_options.border = _G.border
    require("language_servers.keymaps")
  end,
}
