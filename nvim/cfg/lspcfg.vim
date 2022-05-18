lua << EOF
local nvim_lsp = require('lspconfig')
local util = require('lspconfig.util')

local custom_on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=false }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  if client.server_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

-- Highlight line number instead of having icons in sign column
-- vim.cmd [[
--   sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticError
--   sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=DiagnosticWarn 
--   sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=DiagnosticInfo 
--   sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=DiagnosticHint 
-- ]]

-- diagnostic after each line
vim.diagnostic.config({
  virtual_text = {
    prefix = 'σ`∀´)σ '
  },
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  source = true,
  float = {header="Hahahahaha", prefix = "σ`∀´)σ ", scope = "c"},
})

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- Snippets
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false;
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

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
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {max_width=100}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {max_width=100}),
}
local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    handlers = handlers,
    on_attach = custom_on_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = false,
      suggestFromUnimportedLibraries = false,
    },
  }, config)

  nvim_lsp[server].setup(config)
end

local servers = {
  -- pylsp = {
  --   root_dir = util.root_pattern(unpack({
  --     'requirements.txt',
  --     'environment.yaml',
  --     '.gitignore',
  --     'pyproject.toml',
  --     'setup.py',
  --     'setup.cfg',
  --     'Pipfile',
  --   })),
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         jedi_completion = { cache_for={"pytorch", "numpy"}, fuzzy=true },
  --         flake8 = { enabled=false, maxLineLength=100 },
  --         pycodestyle = { enabled=true, maxLineLength=100 },
  --         pydocstyle = { enabled=false, maxLineLength=100 },
  --         pyflakes = { enabled=false },
  --       },
  --     },
  --   },
  -- },
  -- jedi_language_server = util.root_pattern(
  --   unpack({
  --     'pyproject.toml',
  --     'setup.py',
  --     'setup.cfg',
  --     'requirements.txt',
  --     'Pipfile',
  --     '.gitignore',
  --     '.git',
  --   })
  -- ),
  pyright = {
    root_dir = util.root_pattern(unpack({
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.gitignore',
      '.git',
    })),
  },
  vimls = true,
  bashls = true,
  diagnosticls = true,
  yamlls = true,
  ccls = {
    init_options = {
      closingLabels = true,
      compilationDatabaseDirectory = "build";
      index = {
        threads = 0;
      },
      clang = {
        excludeArgs = { "-frounding-math"} ;
      },
      cache = {
        directory = ".ccls-cache";
      },
    },
  },
}
for server, config in pairs(servers) do
  setup_server(server, config)
end
