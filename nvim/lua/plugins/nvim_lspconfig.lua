return {
  {
    "williamboman/mason-lspconfig.nvim",
    ft = { "lua", "c", "cpp", "python" },
    config = function()
      local handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup()
        end,
        ["clangd"] = require("language_servers.clangd"),
        ["lua_ls"] = require("language_servers.lua_ls"),
        ["pyright"] = require("language_servers.pyright"),
        ["ruff_lsp"] = require("language_servers.ruff_lsp"),
        ["texlab"] = require("language_servers..texlab"),
      }

      require("mason-lspconfig").setup({ handlers = handlers })
    end,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          inlay_hints = { enabled = true },
        },
        cmd = { "LspInfo" },
        dependencies = { "folke/neodev.nvim", "hrsh7th/nvim-cmp" },
        config = function()
          require("language_servers.defaults")
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
        end,
      },
      {
        "williamboman/mason.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        cmd = { "Mason" },
        keys = {
          { "<leader>m", "<cmd>Mason<cr>" },
        },
        config = function()
          require("neodev").setup({}) -- for lua_ls
          require("mason").setup({ ui = { border = BORDER, height = 0.8 } })
        end,
      },
    },
  },
}
