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
    vim.keymap.set(
      "n",
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<cr>",
      { buffer = ev.buf, desc = "go to declaration" }
    )
    vim.keymap.set(
      "n",
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<cr>",
      { buffer = ev.buf, desc = "go to definition" }
    )
    vim.keymap.set(
      "n",
      "gi",
      "<cmd>lua vim.lsp.buf.implementation()<cr>",
      { buffer = ev.buf, desc = "go to implementation" }
    )
    vim.keymap.set(
      "n",
      "gt",
      "<cmd>lua vim.lsp.buf.type_definition()<cr>",
      { buffer = ev.buf, desc = "go to type type_definition" }
    )
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "lsp hover" })
    vim.keymap.set(
      "n",
      "gs",
      vim.lsp.buf.signature_help,
      { buffer = ev.buf, desc = "signature help" }
    )
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "signature help" })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "lsp rename" })
    vim.keymap.set("n", "gh", toggle_inlay_hints, { buffer = ev.buf, desc = "toggle inlay hints" })
    vim.keymap.set(
      "n",
      "<space>i",
      toggle_lsp_highlight,
      { buffer = ev.buf, desc = "toggle lsp highlight" }
    )
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
    vim.keymap.set(
      "n",
      "<space>wa",
      vim.lsp.buf.add_workspace_folder,
      { buffer = ev.buf, desc = "add workspace folder" }
    )
    vim.keymap.set(
      "n",
      "<space>wr",
      vim.lsp.buf.remove_workspace_folder,
      { buffer = ev.buf, desc = "remove workspace folder" }
    )
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "print workspace folder" })
  end,
})
