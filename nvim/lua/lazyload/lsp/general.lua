local g = require("tuo.global")
local config = function(server_name, capabilities)
  return {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = g.border,
        title = " " .. server_name .. " ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Signature ", max_width = 100 }
      ),
    },
    capabilities = capabilities,
  }
end

return config
