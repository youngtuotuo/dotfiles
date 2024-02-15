return function()
  require("lspconfig").pyright.setup({
    handlers = {
      ["textDocument/publishDiagnostics"] = function() end,
    },
    settings = {
      pyright = {
        -- Disables the “Organize Imports” command. This is useful if you are using another extension that provides similar functionality and you don’t want the two extensions to fight each other.
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          ignore = { "*" },
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
          logLevel = "Information",
          autoImportCompletions = true,
          autoSearchPaths = false,
          diagnosticMode = "off",
          typeCheckingMode = "off",
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end
