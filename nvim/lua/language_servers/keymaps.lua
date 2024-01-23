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

-- stylua: ignore start
vim.keymap.set("n", "gl",
  function() vim.diagnostic.open_float({ bufnr = 0, scope = "line", source = "if_many", header = "", focusable = false, }) end,
  { desc = "show line diagnostics" }
)
vim.keymap.set("n", "[d",
  function() vim.diagnostic.goto_prev({ severity = get_highest_error_severity(), wrap = true, float = false, }) end,
  { desc = "go to previous diagnostic" }
)
vim.keymap.set("n", "]d",
  function() vim.diagnostic.goto_next({ severity = get_highest_error_severity(), wrap = true, float = false, }) end,
  { desc = "go to next diagnostic" }
)
-- stylua: ignore end

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

vim.g.inlay_hints_visible = false
local function toggle_inlay_hints()
  if vim.g.inlay_hints_visible then
    vim.g.inlay_hints_visible = false
    vim.lsp.inlay_hint.enable(0, false)
  else
    vim.g.inlay_hints_visible = true
    vim.lsp.inlay_hint.enable(0, true)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspconfig", {}),
  callback = function(ev)
    -- stylua: ignore start
    -- vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,             { buffer = ev.buf, desc = "go to declaration" })
    vim.keymap.set("n", "gd",        vim.lsp.buf.definition,              { buffer = ev.buf, desc = "go to definition" })
    -- vim.keymap.set("n", "gi",        vim.lsp.buf.implementation,          { buffer = ev.buf, desc = "go to implementation" })
    vim.keymap.set("n", "gt",        vim.lsp.buf.type_definition,         { buffer = ev.buf, desc = "go to type type_definition" })
    vim.keymap.set("n", "K",         vim.lsp.buf.hover,                   { buffer = ev.buf, desc = "lsp hover" })
    vim.keymap.set("n", "<space>s",  vim.lsp.buf.signature_help,          { buffer = ev.buf, desc = "signature help" })
    vim.keymap.set("n", "<space>n",  vim.lsp.buf.rename,                  { buffer = ev.buf, desc = "lsp rename" })
    vim.keymap.set("n", "<space>h",  toggle_inlay_hints,                  { buffer = ev.buf, desc = "toggle inlay hints" })
    vim.keymap.set("n", "<space>i",  toggle_lsp_highlight,                { buffer = ev.buf, desc = "toggle lsp highlight"})
    vim.keymap.set("n", "<space>a",  vim.lsp.buf.code_action,             { buffer = ev.buf, desc = "code action" })
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,    { buffer = ev.buf, desc = "add workspace folder" })
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "remove workspace folder" })
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,     { buffer = ev.buf, desc = "print workspace folder" }
    )
  end,
})
