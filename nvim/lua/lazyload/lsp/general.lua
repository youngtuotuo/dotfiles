local config = function(server_name, on_attach, capabilities, util)
  return {
    on_attach = on_attach,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = BORDER,
        title = " " .. server_name .. " ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = BORDER, title = " Signature ", max_width = 100 }
      ),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          source = "always",
          title = " " .. server_name .. " σ`∀´)σ ",
          border = BORDER,
          max_width = 80,
        },
        source = true,
      }),
    },
    capabilities = capabilities,
  }
end

return config
