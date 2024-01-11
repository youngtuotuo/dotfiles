local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
-- for clangd
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig.util").default_config.capabilities = capabilities

