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
  end

  local signs = { Error = "* ", Warn = "! ", Hint = "> ", Info = "- " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- diagnostic after each line
  vim.diagnostic.config({
    virtual_text = {
      prefix = '好笨 σ`∀´)σ ',
      format = function(diagnostic)
        return ''
      end
    },
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    source = true,
    float = {header="Yayayayayayaya", prefix = "好笨 σ`∀´)σ ", scope = "c"},
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
  local border = "double"
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  local handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {max_width=120}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {max_width=120}),
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
