require("lspconfig.ui.windows").default_options.border = BORDER

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig.util").default_config.capabilities = capabilities

local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    header = true,
    prefix = function()
      return ""
    end,
    focusable = true,
    title = " σ`∀´)σ ",
    border = BORDER,
    max_width = 80,
  },
}

vim.diagnostic.config(diag_config)

local function split_lines(value)
  value = string.gsub(value, "&nbsp;", " ")
  value = string.gsub(value, "&gt;", ">")
  value = string.gsub(value, "&lt;", "<")
  value = string.gsub(value, "\\", "")
  value = string.gsub(value, "%[", "%[%[")
  value = string.gsub(value, "%]", "%]%]")
  value = string.gsub(value, "```%a*\n", "")
  value = string.gsub(value, "```", "")
  value = string.gsub(value, "`_", "`")
  return { value }
end

local function hover(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end
  if not (result and result.contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  return require("vim.lsp.util").open_floating_preview(
    split_lines(result.contents.value),
    result.contents.kind,
    config
  )
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(hover, {
    border = BORDER,
    title = " Hover ",
    max_width = 100,
    max_height = 20,
    zindex = 500,
    focusable = true,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = BORDER, title = " Signature ", max_width = 100 }
  ),
}
require("lspconfig.util").default_config.handlers = handlers
