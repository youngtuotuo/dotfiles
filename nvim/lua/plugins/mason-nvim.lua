local ok, wf = pcall(require, "vim.lsp._watchfiles")
wf._watchfunc = function()
  return function() end
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
        "pyright",
        "lua-language-server",
        -- "gopls",
        -- "rust_analyzer",
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
    end,
    config = function(_, opts)
      require("lspconfig").zls.setup({})
      require("lspconfig").clangd.setup({})
      require("lspconfig").lua_ls.setup({
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
      require("lspconfig").pyright.setup({
        settings = {
          pyright = {
            disableOrganizeImports = false,
          },
          python = {
            analysis = {
              ignore = { "*" },
              logLevel = "Information",
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "off",
              typeCheckingMode = "off",
              useLibraryCodeForTypes = false,
            },
          },
        },
      })
      -- capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      require("lspconfig.util").default_config.capabilities = capabilities

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

      vim.g.inlay_hints_visible = false
      local function toggle_inlay_hints()
        if vim.g.inlay_hints_visible then
          vim.g.inlay_hints_visible = false
          vim.lsp.inlay_hint.enable(0, false)
        else
          vim.g.inlay_hints_visible = true
          vim.lsp.inlay_hint.enable(0, true)
        end
      end

      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspconfig", {}),
        callback = function(ev)
          vim.keymap.set(
            "n",
            "gD",
            "<cmd>lua vim.lsp.buf.declaration()<cr>",
            { buffer = ev.buf, desc = "go to declaration" }
          )
          vim.keymap.set(
            "n",
            "gd",
            "<cmd>lua vim.lsp.buf.definition()<cr>",
            { buffer = ev.buf, desc = "go to definition" }
          )
          vim.keymap.set(
            "n",
            "gi",
            "<cmd>lua vim.lsp.buf.implementation()<cr>",
            { buffer = ev.buf, desc = "go to implementation" }
          )
          vim.keymap.set(
            "n",
            "gt",
            "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            { buffer = ev.buf, desc = "go to type type_definition" }
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "lsp hover" })
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature help" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "signature help" })
          vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "lsp rename" })
          vim.keymap.set("n", "gh", toggle_inlay_hints, { buffer = ev.buf, desc = "toggle inlay hints" })
          vim.keymap.set("n", "<space>i", toggle_lsp_highlight, { buffer = ev.buf, desc = "toggle lsp highlight" })
          vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
          vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "add workspace folder" }
          )
          vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "remove workspace folder" }
          )
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = ev.buf, desc = "print workspace folder" })
        end,
      })
    end,
  },
}
