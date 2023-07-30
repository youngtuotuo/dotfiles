local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("lspconfig.ui.windows").default_options.border = BORDER
require("neodev").setup({})
require("mason").setup({ ui = { border = BORDER } })
-- Ensure the servers above are installed
local servers = {
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "texlab",
  "html",
  "yamlls",
  "gopls",
  "lemminx",
  "hls",
  "pylsp",
}
require("mason-lspconfig").setup({ ensure_installed = servers })

local diag_config = {
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = { focusable = true, source = "always", title = " σ`∀´)σ ", border = BORDER, max_width = 80 },
  source = true,
}

vim.diagnostic.config(diag_config)

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local util = require("lspconfig.util")

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = false }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  buf_set_keymap("n", "gic", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
  buf_set_keymap("n", "goc", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local function filter(arr, func)
  -- Filter in place
  -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
  local new_index = 1
  local size_orig = #arr
  for old_index, v in ipairs(arr) do
    if func(v, old_index) then
      arr[new_index] = v
      new_index = new_index + 1
    end
  end
  for i = new_index, size_orig do
    arr[i] = nil
  end
end

local function pyright_accessed_filter(diagnostic)
  -- Allow kwargs to be unused, sometimes you want many functions to take the
  -- same arguments but you don't use all the arguments in all the functions,
  -- so kwargs is used to suck up all the extras
  if diagnostic.message == '"kwargs" is not accessed' then
    return false
  elseif diagnostic.message == '"args" is not accessed' then
    return false
  elseif diagnostic.message == '"_.+"reportGeneralTypeIssues' then
    return false
  end
  -- Allow variables starting with an underscore
  -- if string.match(diagnostic.message, '"_.+" is not accessed') then
  -- 	return false
  -- end
  -- For all messages "is not accessed"
  -- if string.match(diagnostic.message, '".+" is not accessed') then
  --     return false
  -- end

  return true
end

local function custom_on_publish_diagnostics(a, params, client_id, c, config)
  filter(params.diagnostics, pyright_accessed_filter)
  vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = BORDER,
          title = " " .. server_name .. " ",
          max_width = 100,
          zindex = 500,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = BORDER, title = " Signature ", max_width = 100 }
        ),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {}),
      },
      capabilities = capabilities,
    })
  end,
  ["pylsp"] = function()
    lspconfig.pylsp.setup({
      on_attach = on_attach,
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = BORDER,
          title = " pylsp ",
          max_width = 100,
          zindex = 500,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = BORDER, title = " Signature ", max_width = 100 }
        ),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {}),
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
                "matplotlib"
              },
              include_class_objects = true,
              include_function_objects = true,
              fuzzy = true,
            },
          },
        },
      },
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = BORDER,
          title = " LuaLS ",
          max_width = 100,
          zindex = 500,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = BORDER, title = " Signature ", max_width = 100 }
        ),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {}),
      },
      capabilities = capabilities,
      root_dir = util.root_pattern(unpack({
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
      })),
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = { globals = { "vim", "use" } },
          completion = { callSnippet = "Both" },
          workspace = { checkThirdParty = false },
          semantic = { enable = false },
        },
      },
    })
  end,
  ["texlab"] = function()
    lspconfig.texlab.setup({
      on_attach = on_attach,
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = BORDER,
          title = " TexLab ",
          max_width = 100,
          zindex = 500,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = BORDER, title = " Signature ", max_width = 100 }
        ),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {}),
      },
      capabilities = capabilities,
      settings = {
        texlab = {
          rootDirectory = nil,
          build = {
            executable = "latexmk",
            args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
            -- executable = 'xelatex',
            onSave = false,
            forwardSearchAfter = false,
          },
          auxDirectory = ".",
          forwardSearch = { executable = nil, args = {} },
          chktex = { onOpenAndSave = false, onEdit = false },
          diagnosticsDelay = 300,
          latexFormatter = "latexindent",
          latexindent = {
            ["local"] = nil, -- local is a reserved keyword
            modifyLineBreaks = false,
          },
          bibtexFormatter = "texlab",
          formatterLineLength = 80,
        },
      },
    })
  end,
})
