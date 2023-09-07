local g = require("tuo.global")
local config = function(on_attach, capabilities, util)
  return {
    on_attach = on_attach,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = g.border,
        title = " TexLab ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Signature ", max_width = 100 }
      ),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = false,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          source = "always",
          title = " Texlab σ`∀´)σ ",
          border = g.border,
          max_width = 80,
        },
        source = true,
      }),
    },
    capabilities = capabilities,
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = "latexmk",
          args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
          -- executable = 'xelatex',
          onSave = false,
          forwardSearchAfter = false,
        },
        auxDirectory = ".",
        forwardSearch = { executable = nil, args = {} },
        chktex = { onOpenAndSave = false, onEdit = false },
        diagnosticsDelay = 300,
        latexFormatter = "latexindent",
        latexindent = {
          ["local"] = nil, -- local is a reserved keyword
          modifyLineBreaks = false,
        },
        bibtexFormatter = "texlab",
        formatterLineLength = 80,
      },
    },
  }
end

return config
