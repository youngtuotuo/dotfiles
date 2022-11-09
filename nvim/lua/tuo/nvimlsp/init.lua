local status_ok, nvim_lsp = pcall(require, "lspconfig")

if not status_ok then
  return
end

local util = require("lspconfig.util")

local servers = {
  pyright = {
    root_dir = util.root_pattern(unpack({
      '.gitignore',
      '.git',
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
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
          logLevel = "Error",
          -- Determines whether pyright offers auto-import completions.
          autoImportCompletions = ture,
          -- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
          autoSearchPaths = false,
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
  },
  clangd = {},
  texlab = {
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = 'latexmk',
          args = { '-xelatex', '-interaction=nonstopmode', '-synctex=1', '%f' },
          -- executable = 'xelatex',
          args = {},
          onSave = false,
          forwardSearchAfter = false,
        },
        auxDirectory = '.',
        forwardSearch = {
          executable = nil,
          args = {},
        },
        chktex = {
          onOpenAndSave = false,
          onEdit = false,
        },
        diagnosticsDelay = 300,
        latexFormatter = 'latexindent',
        latexindent = {
          ['local'] = nil, -- local is a reserved keyword
          modifyLineBreaks = false,
        },
        bibtexFormatter = 'texlab',
        formatterLineLength = 80,
      },
    },
  },
}
require("tuo.nvimlsp.handlers").setup(servers, nvim_lsp)
