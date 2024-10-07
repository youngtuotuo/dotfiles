-- diagnostic
local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  float = {
    focusable = true,
    source = true,
  },
}

vim.diagnostic.config(diag_config)
vim.diagnostic.enable(false)
local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

vim.keymap.set("n", "<M-d>", toggle_diagnostics, { desc = "toggle diagnostic" })

-- overload default float win
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.max_width = _G.floatw
  opts.max_height = _G.floath
  opts.wrap = _G.floatwrap
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local fts = { "yaml", "html", "markdown", "json", "python", "sh", "lua", "c", "cpp", "cuda", "zig" }

return {
  {
    "williamboman/mason.nvim",
    ft = fts,
    init = function()
      vim.api.nvim_create_user_command("M", "Mason", {})
    end,
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    -- Better installer than default
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = function()
      return {
        ensure_installed = {
          -- lsp --
          "clangd",
          "basedpyright",
          "lua-language-server",
          "zls",
          -- formatter --
          "jq",
          "ruff",
          "shfmt",
          "stylua",
          "codelldb",
          "debugpy",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "zig", "c", "cpp", "cuda", "python", "lua", "mojo" },
    cmd = { "LspInfo" },
    dependencies = {
      "williamboman/mason.nvim",
      -- Better installer than default
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    init = function()
      vim.api.nvim_create_user_command("LI", "LspInfo", {})

      -- customize hover when pressing K
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        zindex = 500,
        focusable = true,
        max_width = _G.floatw,
      })

      -- customize signature help when pressing gs
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        max_width = _G.floatw,
      })
    end,
    config = function(_, _)
      -- disable all format, use conform with mason
      require("lspconfig.util").default_config.format = {
        formatting_options = nil,
        timeout_ms = nil,
      }
      require("lspconfig.ui.windows").default_options.border = "single"

      local lsp_highlight = false
      local toggle_lsp_highlight = function()
        if lsp_highlight then
          vim.lsp.buf.clear_references()
          lsp_highlight = false
        else
          vim.lsp.buf.document_highlight()
          lsp_highlight = true
        end
      end

      vim.keymap.set("n", "<space>i", toggle_lsp_highlight, { desc = "toggle lsp highlight" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "lsp signature help" })
      -- vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "lsp rename" })
      -- vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "code action" })
      -- vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "references" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "type definition" })

      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
      vim.keymap.set("n", "gh", toggle_inlay_hints, { desc = "toggle inlay hints" })

      require("lspconfig").mojo.setup({
        manual_install = true,
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
      require("lspconfig").zls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
      require("lspconfig").clangd.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
      require("lspconfig").lua_ls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
          Lua = {
            runtime = { version = "Lua 5.1" },
            diagnostics = { globals = { "vim", "use" } },
            completion = { callSnippet = "Both" },
            workspace = { checkThirdParty = false },
            semantic = { enable = false },
            hint = { enable = true },
          },
        },
      })
      require("lspconfig").basedpyright.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
        end,
        settings = {
          basedpyright = {
            disableOrganizeImports = false,
            analysis = {
              logLevel = "Information",
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = false,
            },
          },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "nvim-dap-ui",
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "stevearc/aerial.nvim",
    lazy = true,
    keys = function()
      local toggle = function()
        require("aerial").toggle({ focus = true })
      end
      return {
        { "<space>o", toggle, noremap = true, desc = "Code outline" },
      }
    end,
    opts = {
      layout = {
        default_direction = "left",
        max_width = 30,
        min_width = 30,
      },
    },
  },
}
