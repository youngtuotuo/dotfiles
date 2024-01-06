return {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end,
  -- handlers = {
  --   ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {}),
  -- },
  init_options = {
    settings = {
      args = { "--ignore=E701,E702" },
    },
  }
}
