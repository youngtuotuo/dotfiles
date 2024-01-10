return function()
  require("lspconfig").telab.setup({
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
  })
end
