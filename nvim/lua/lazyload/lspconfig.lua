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
    show_header = true,
    focusable = true,
    source = "always",
    title = " σ`∀´)σ ",
    border = g.border,
    max_width = 80,
    format = function(d)
      if not d.code and not d.user_data then
        return d.message
      end

      local t = vim.deepcopy(d)
      local code = d.code
      if not code then
        if not d.user_data.lsp then
          return d.message
        end

        code = d.user_data.lsp.code
      end
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
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

-- Go to the next diagnostic, but prefer going to errors first
-- In general, I pretty much never want to go to the next hint
local severity_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.HINT,
}

local get_highest_error_severity = function()
  for _, level in ipairs(severity_levels) do
    local diags = vim.diagnostic.get(0, { severity = { min = level } })
    if #diags > 0 then
      return level, diags
    end
  end
end

-- Global mappings
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float(0, {
    scope = "line",
  })
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({
    severity = get_highest_error_severity(),
    wrap = true,
    float = true,
  })
end)
