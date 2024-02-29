return function()
  require("lspconfig").pyright.setup({
    settings = {
      python = {
        analysis = {
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
          logLevel = "Information",
          autoImportCompletions = true,
          autoSearchPaths = false,
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end
