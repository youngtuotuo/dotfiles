local config = function(capabilities, util)
  return {
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {}),
    },
    capabilities = capabilities,
    root_dir = util.root_pattern(unpack({
      ".gitignore",
      "pyproject.toml",
    })),
    init_options = {
      settings = {
        args = { "--ignore=E701,E702" },
      },
    }
  }
end

return config

