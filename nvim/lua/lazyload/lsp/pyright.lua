local config = function(on_attach, capabilities, util)
  return {
    on_attach = on_attach,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = BORDER,
        title = " Pyright ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = BORDER, title = " Signature ", max_width = 100 }
      ),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          source = "always",
          title = " Pyright σ`∀´)σ ",
          border = BORDER,
          max_width = 80,
        },
        source = true,
      }),
    },
    capabilities = capabilities,
    root_dir = util.root_pattern(unpack({
      -- "pyproject.toml",
      -- "setup.py",
      -- "setup.cfg",
      -- "requirements.txt",
      -- "Pipfile",
      "pyrightconfig.json",
      -- "pyvenv.cfg",
    })),
    settings = {
      pyright = {
        -- Disables the “Organize Imports” command. This is useful if you are using another extension that provides similar functionality and you don’t want the two extensions to fight each other.
        disableOrganizeImports = false,
      },
      python = {
        analysis = {
          -- Level of logging for Output panel. The default value for this option is "Information".
          -- ["Error", "Warning", "Information", or "Trace"]
          logLevel = "Information",
          -- Determines whether pyright offers auto-import completions.
          autoImportCompletions = true,
          -- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
          autoSearchPaths = true,
          -- Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file. If this option is set to "openFilesOnly", pyright analyzes only open files.
          -- ["openFilesOnly", "workspace"]
          diagnosticMode = "openFilesOnly",
          -- Path to directory containing custom type stub files.
          -- stubPath = {},
          -- Determines the default type-checking level used by pyright. This can be overridden in the configuration file. (Note: This setting used to be called "pyright.typeCheckingMode". The old name is deprecated but is still currently honored.)
          -- ["off", "basic", "strict"]
          typeCheckingMode = "off",
          -- Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files. Type information will typically be incomplete. We recommend using type stubs where possible. The default value for this option is false.
          useLibraryCodeForTypes = false,
        },
      },
    },
  }
end

return config
