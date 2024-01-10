require("lspconfig.ui.windows").default_options.border = BORDER

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
-- for clangd
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig.util").default_config.capabilities = capabilities

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
-- stylua: ignore
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float({ bufnr = 0, scope = "line", source = "if_many", header = "", focusable = false, }) end)
-- stylua: ignore
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ severity = get_highest_error_severity(), wrap = true, float = false, }) end)
-- stylua: ignore
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ severity = get_highest_error_severity(), wrap = true, float = false, }) end)

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

local format = {
  formatting_options = nil,
  timeout_ms = nil,
}
require("lspconfig.util").default_config.format = format
