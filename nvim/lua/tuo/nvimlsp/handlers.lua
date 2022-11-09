local M = {}

M.setup = function(servers, nvim_lsp)
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
  require("rust-tools").setup({
    server = {
      on_init = custom_init,
      handlers = handlers,
      capabilities = updated_capabilities,
      on_attach = custom_on_attach,
    },
  })
end

return M

