return function()
  require("lspconfig").ruff_lsp.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end,
    init_options = {
      settings = {
        args = { "--ignore=E701,E702" },
      },
    },
  })
end
