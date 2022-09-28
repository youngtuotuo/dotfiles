local status_ok, nvim_lsp = pcall(require, "lspconfig")

if not status_ok then
  return
end

local util = require("lspconfig.util")

local servers = {
  pylsp = {
    root_dir = util.root_pattern(unpack({
      '.gitignore', '.git', 'pyproject.toml', 'setup.py', 'setup.cfg',
      'requirements.txt', 'Pipfile', 'pyrightconfig.json', 'main.py'
    })),
    settings = {
      pylsp = {
        plugins = {pycodestyle = {ignore = {}, maxLineLength = 100}},
        autopep8 = {enabled = false},
        pydocstyle = {enabled = false},
        McCabe = {enabled = false}
      }
    }
  },
  ccls = {
    init_options = {
      closingLabels = true,
      compilationDatabaseDirectory = "build",
      index = {threads = 0},
      clang = {excludeArgs = {"-frounding-math"}},
      cache = {directory = ".ccls-cache"}
    }
  },
}
require("tuo.lsp.handlers").setup(servers, nvim_lsp)
