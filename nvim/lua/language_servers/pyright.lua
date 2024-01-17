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
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
          -- Level of logging for Output panel. The default value for this option is "Information".
          -- ["Error", "Warning", "Information", or "Trace"]
          logLevel = "Information",
          -- Determines whether pyright offers auto-import completions.
          autoImportCompletions = true,
          -- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
          autoSearchPaths = false,
          -- Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file. If this option is set to "openFilesOnly", pyright analyzes only open files.
          -- ["off", "openFilesOnly", "workspace"]
          diagnosticMode = "off",
          -- Path to directory containing custom type stub files.
          -- stubPath = {},
          -- Determines the default type-checking level used by pyright. This can be overridden in the configuration file. (Note: This setting used to be called "pyright.typeCheckingMode". The old name is deprecated but is still currently honored.)
          -- ["off", "basic", "strict"]
          typeCheckingMode = "off",
          -- Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files. Type information will typically be incomplete. We recommend using type stubs where possible. The default value for this option is false.
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end
