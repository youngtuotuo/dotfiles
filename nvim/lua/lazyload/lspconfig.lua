local g = require("tuo.global")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
require("lspconfig.ui.windows").default_options.border = g.border
require("neodev").setup({}) -- for lua_ls
require("mason").setup({ ui = { border = g.border } })

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
    vim.keymap.set(
      "n",
      "<space>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
      opts
    )
    -- vim.keymap.set("n", "gic", vim.lsp.buf.incoming_calls, opts)
    -- vim.keymap.set("n", "goc", vim.lsp.buf.outgoing_calls, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.inlay_hint(0, nil)<cr>", opts)
    vim.keymap.set("n", "<space>i", toggle_lsp_highlight)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local cfg = require("lazyload.lsp.general")(server_name, capabilities)
    lspconfig[server_name].setup(cfg)
  end,
  ["lua_ls"] = function()
    local cfg = require("lazyload.lsp.lua_ls")(capabilities, util)
    lspconfig.lua_ls.setup(cfg)
  end,
  ["pyright"] = function()
    local cfg = require("lazyload.lsp.pyright")(capabilities, util)
    lspconfig.pyright.setup(cfg)
  end,
  -- ["texlab"] = function()
  --   lspconfig.texlab.setup(require("lazyload.lsp.texlab")(capabilities))
  -- end,
}

require("mason-lspconfig").setup({ handlers = handlers })

local diag_config = {
  virtual_text = false,
  signs = true,
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

local ns = vim.api.nvim_create_namespace("CurlineDiag")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = args.buf,
      callback = function()
        pcall(vim.api.nvim_buf_clear_namespace, args.buf, ns, 0, -1)
        local hi = { "Error", "Warn", "Info", "Hint" }
        local icons = { " ", " ", " ", " " }
        local curline = vim.api.nvim_win_get_cursor(0)[1]
        local diagnostics = vim.diagnostic.get(args.buf, { lnum = curline - 1 })
        local virt_texts = { { (" "):rep(4) } }
        for _, diag in ipairs(diagnostics) do
          virt_texts[#virt_texts + 1] =
            { icons[diag.severity] .. diag.message, "Diagnostic" .. hi[diag.severity] }
        end
        vim.api.nvim_buf_set_extmark(args.buf, ns, curline - 1, 0, {
          virt_text = virt_texts,
          hl_mode = "combine",
          virt_text_pos = "eol"
        })
      end,
    })
  end,
})

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
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
    float = false,
  })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({
    severity = get_highest_error_severity(),
    wrap = true,
    float = false,
  })
end)
