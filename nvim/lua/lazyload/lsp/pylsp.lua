local g = require("tuo.global")
local config = function(on_attach, capabilities, util)
  vim.env.MYPYPATH = vim.fn.stdpath("data") .. "/lazy/python-type-stubs"
  return {
    on_attach = on_attach,
    root_dir = function(fname)
      local root_files = {
        "pyproject.toml",
      }
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = g.border,
        title = " pylsp ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Signature ", max_width = 100 }
      ),
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = false,
          underline = false,
          update_in_insert = false,
          severity_sort = true,
          float = {
            focusable = true,
            source = "always",
            title = " Pylsp σ`∀´)σ ",
            border = g.border,
            max_width = 80,
          },
          source = true,
      }),
    },
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 120,
          },
          autopep8 = {
            enabled = false,
          },
          yapf = {
            enabled = false,
          },
          mccabe = {
            enabled = true,
            threshold = 15,
          },
          rope_autoimport = {
            enabled = true,
          },
          jedi_completion = {
            cache_for = {
              "pytorch",
              "scipy",
              "numpy",
              "matplotlib",
            },
            include_class_objects = true,
            include_function_objects = true,
            fuzzy = true,
          },
        },
      },
    },
  }
end

return config
