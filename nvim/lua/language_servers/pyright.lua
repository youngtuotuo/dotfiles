return function()
  require("lspconfig").pyright.setup({
    settings = {
      pyright = {
        disableOrganizeImports = false,
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
          useLibraryCodeForTypes = false,
        },
      },
    },
  })
end
