-- customize hover when pressing K
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = _G.border,
    title = " |･ω･) ? ",
    zindex = 500,
    focusable = true,
    max_width = 100,
  }
)
-- customize signature help when pressing gs
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = _G.border,
    title = " (・・ ) ? ",
    max_width = _G.floatw,
  }
)
