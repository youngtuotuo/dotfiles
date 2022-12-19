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
  rust_analyzer = {},
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
  sumneko_lua = {
    settgins = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      }
    }
  },
}

local custom_on_attach = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', {clear = false})
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight'
    })
    vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = {noremap = true, silent = false}
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa',
                 '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr',
                 '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl',
                 '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                 opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>i',
                 '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- local border = "rounded"
local border = nil
-- diagnostic after each line
local diag_config = {
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = border,
    source = "always",
    header = "",
    prefix = "σ`∀´)σ ",
  },
  source = true
}

vim.diagnostic.config(diag_config)

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.codeLens = {dynamicRegistration = false}
default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities.offsetEncoding = {"utf-8"}
default_capabilities = require("cmp_nvim_lsp").default_capabilities(
                           default_capabilities)

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                                        { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                                                { border = border })
}
local setup_server = function(server, config)
  if not config then return end

  if type(config) ~= "table" then config = {} end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    handlers = handlers,
    on_attach = custom_on_attach,
    capabilities = default_capabilities,
    flags = {debounce_text_changes = nil},
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = false,
      suggestFromUnimportedLibraries = false
    }
  }, config)

  nvim_lsp[server].setup(config)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
for server, config in pairs(servers) do setup_server(server, config) end
