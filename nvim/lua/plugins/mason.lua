return {
  {
    "williamboman/mason-lspconfig.nvim",
    ft = { "lua", "c", "cpp", --[[ "rust", "tex", "html",  ]]"python", --[[ "yaml", "go", "haskell", "xml" ]] },
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        event = "BufRead",
        cmd = { "LspInfo" },
        dependencies = { "folke/neodev.nvim", "hrsh7th/nvim-cmp" },
      },
      {
        "williamboman/mason.nvim",
        event = "BufRead",
        cmd = { "Mason" },
        config = function()
          local g = require("global")
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")
          require("lspconfig.ui.windows").default_options.border = g.border
          require("neodev").setup({}) -- for lua_ls
          require("mason").setup({ ui = { border = g.border } })

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

          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspconfig", {}),
            callback = function(ev)
              -- Enable completion triggered by <c-x><c-o>
              -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
              -- Mappings.
              local opts = { buffer = ev.buf }
              -- See `:help vim.lsp.*` for documentation on any of the below functions
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
              vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
              vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
              vim.keymap.set("n", "gn", vim.lsp.buf.rename, opts)
              vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
              vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
              vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, opts)
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
              vim.keymap.set("n", "gh", toggle_inlay_hints, opts)
              vim.keymap.set("n", "<space>i", toggle_lsp_highlight)
              vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
            end,
          })

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

          local handlers = {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
              local cfg = require("lsp.general")(server_name, capabilities)
              lspconfig[server_name].setup(cfg)
            end,
            ["lua_ls"] = function()
              local cfg = require("lsp.lua_ls")(capabilities, util)
              lspconfig.lua_ls.setup(cfg)
            end,
            ["pyright"] = function()
              local cfg = require("lsp.pyright")(capabilities, util)
              lspconfig.pyright.setup(cfg)
            end,
            ["clangd"] = function()
              -- if vim.fn.has("win32") == 0 then
              local cfg = require("lsp.clangd")(capabilities, util)
              lspconfig.clangd.setup(cfg)
              -- end
            end,
            ["ruff_lsp"] = function()
              local cfg = require("lsp.ruff_lsp")(capabilities, util)
              lspconfig.ruff_lsp.setup(cfg)
            end,
            -- ["texlab"] = function()
            --   lspconfig.texlab.setup(require("lsp.texlab")(capabilities))
            -- end,
          }

          require("mason-lspconfig").setup({ handlers = handlers })

          local diag_config = {
            virtual_text = true,
            signs = false,
            underline = false,
            update_in_insert = false,
            severity_sort = true,
            float = {
              header = true,
              prefix = function()
                return ""
              end,
              focusable = true,
              title = " σ`∀´)σ ",
              border = g.border,
              max_width = 80,
            },
          }

          vim.diagnostic.config(diag_config)

          -- Go to the next diagnostic, but prefer going to errors first
          -- In general, I pretty much never want to go to the next hint
          local severity_levels = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          }

          local get_highest_error_severity = function()
            for _, level in ipairs(severity_levels) do
              local diags = vim.diagnostic.get(0, { severity = { min = level } })
              if #diags > 0 then
                return level, diags
              end
            end
          end

          -- Global mappings
          vim.keymap.set("n", "gl", function()
            vim.diagnostic.open_float({
              bufnr = 0,
              scope = "line",
              source = "if_many",
              header = "",
              focusable = false,
            })
          end)
          vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_prev({
              severity = get_highest_error_severity(),
              wrap = true,
              float = false,
            })
          end)
          vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_next({
              severity = get_highest_error_severity(),
              wrap = true,
              float = false,
            })
          end)
          vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { noremap = true })
        end,
        dependencies = { "neovim/nvim-lspconfig" },
      },
    },
  },
}
