local g = require("tuo.global")
local lspconfig = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = g.border
require("neodev").setup({})
require("mason").setup({ ui = { border = g.border } })
local util = require("lspconfig.util")

local lsp_highlight = false
local toggle_lsp_highlight = function()
  if lsp_highlight then
    vim.lsp.buf.clear_references()
    lsp_highlight = false
  else
    vim.lsp.buf.document_highlight()
    lsp_highlight = true
  end
end

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
    vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", opts)
    vim.keymap.set("n", "gic", vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set("n", "goc", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>i", toggle_lsp_highlight)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup(require("lazyload.lsp.general")(server_name, on_attach, capabilities, util))
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
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    source = "always",
    title = " σ`∀´)σ ",
    border = g.border,
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
