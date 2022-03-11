lua << EOF

local custom_on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
  buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi! LspReferenceRead  ctermbg=238 guibg=#707070 gui=NONE,nocombine
      hi! LspReferenceText  ctermbg=238 guibg=#707070 gui=NONE,nocombine
      hi! LspReferenceWrite ctermbg=238 guibg=#707070 gui=NONE,nocombine
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

-- Show line diagnostics automatically in hover window
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})]]

-- Highlight line number instead of having icons in sign column
vim.cmd [[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticError
  sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=DiagnosticWarn 
  sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=DiagnosticInfo 
  sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=DiagnosticHint 
]]

-- diagnostic after each line
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
  },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'vimls', 'bashls', 'diagnosticls', 'yamlls' }
local handlers = {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {max_width=130, max_height=30}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {max_width=130, max_height=30}),
}
-- 'cmake', 'diagnosticls', 'dockerls'
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    handlers = handlers,
    on_attach = custom_on_attach,
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
    };
    flags = {
      debounce_text_changes = 150,
    }
  }
end
nvim_lsp.ccls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = custom_on_attach,
  flags = {
    debounce_text_changes = 150,
  };
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
    cache = {
      directory = ".ccls-cache";
    };
  } ;
}
EOF
