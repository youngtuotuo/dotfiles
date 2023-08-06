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
  "texlab",
  "html",
  "yamlls",
  "gopls",
  "lemminx",
  "hls",
  "pyright",
}
require("mason-lspconfig").setup({ ensure_installed = servers })
local util = require("lspconfig.util")

-- Global mappings
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspconfig", {}),
  callback = function(ev)
    -- Mappings.
    local opts = { buffer = ev.buf }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set(
      "n",
      "<space>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
      opts
    )
    vim.keymap.set("n", "gic", vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set("n", "goc", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  end,
})

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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup(
      require("lazyload.lsp.general")(server_name, on_attach, capabilities, util)
    )
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup(require("lazyload.lsp.lua_ls")(on_attach, capabilities, util))
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup(require("lazyload.lsp.pyright")(on_attach, capabilities, util))
  end,
  ["texlab"] = function()
    lspconfig.texlab.setup(require("lazyload.lsp.texlab")(on_attach, capabilities, util))
  end,
})

local diag_config = {
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    source = "always",
    title = " σ`∀´)σ ",
    border = BORDER,
    max_width = 80,
  },
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
