local _, wf = pcall(require, "vim.lsp._watchfiles")
wf._watchfunc = function()
  return function() end
end

-- diagnostic
local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  float = {
    focusable = true,
    title = " σ`∀´)σ ",
    border = _G.border,
    source = true,
  },
}

vim.diagnostic.config(diag_config)

local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

vim.keymap.set("n", "<M-d>", toggle_diagnostics, { desc = "toggle diagnostic" })

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

return {
  {
    "williamboman/mason.nvim",
    ft = { "json", "python", "sh", "lua", "c", "cpp", "cuda", "zig" },
    init = function()
      vim.api.nvim_create_user_command("M", "Mason", {})
    end,
    opts = {
      ui = { border = _G.border, width = 0.7, height = 0.5 },
    },
  },
  {
    -- Better installer than default
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = function()
      local ensure_installed = {
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
      }
      return {
        ensure_installed = ensure_installed,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "zig", "c", "cpp", "cuda", "python", "lua" },
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
        border = _G.border,
        title = " |･ω･) ? ",
        zindex = 500,
        focusable = true,
        max_width = 120,
      })

      -- customize signature help when pressing gs
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _G.border,
        title = " (・・ ) ? ",
        max_width = _G.floatw,
      })
    end,
    config = function(_, _)
      -- disable all format, use conform with mason
      require("lspconfig.util").default_config.format = {
        formatting_options = nil,
        timeout_ms = nil,
      }

      -- LspInfo width and height
      local info = require("lspconfig.ui.windows").percentage_range_window
      require("lspconfig.ui.windows").percentage_range_window = function(_, _)
        return info(0.7, 0.5)
      end

      -- LspInfo command border
      require("lspconfig.ui.windows").default_options.border = _G.border

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
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "lsp references" })
      vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "lsp rename" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist, { desc = "diagnostic qflist" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })

      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
      vim.keymap.set("n", "gh", toggle_inlay_hints, { desc = "toggle inlay hints" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function(_, _)
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig").zls.setup({
        capabilities = capabilities,
      })
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
      })
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
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
        capabilities = capabilities,
        settings = {
          basedpyright = {
            disableOrganizeImports = false,
            analysis = {
              logLevel = "Information",
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "all",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
    end,
  },
}
