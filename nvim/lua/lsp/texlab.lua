local g = require("global")
local config = function(capabilities)
  return {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = g.border,
        title = " TexLab ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Texlab ", max_width = 100 }
      ),
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
