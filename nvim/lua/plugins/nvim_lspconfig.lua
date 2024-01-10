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
          keys = { { "<leader>m", "<cmd>Mason<cr>" } },
          opts = {
            ui = { border = BORDER, height = 0.8 },
          },
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
              ["texlab"] = require("language_servers..texlab"),
            },
          },
        },
      },
      config = function(_, opts)
        -- capabilities, diagnostic, and handlers
        require("language_servers.defaults")
        -- keymaps
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
            -- stylua: ignore
            vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
            -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gh", toggle_inlay_hints, opts)
            vim.keymap.set("n", "<space>i", toggle_lsp_highlight)
            vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
          end,
        })
      end,
    },
  },
}
