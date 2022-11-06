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
      },
      python = {
        analysis = {
          autoImportCompletions = ture
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
