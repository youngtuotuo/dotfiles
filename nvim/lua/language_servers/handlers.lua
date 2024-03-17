-- customize hover when pressing K
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = _G.border,
    title = " |･ω･) ? ",
    -- max_height = 20,
    zindex = 500,
    focusable = true,
    -- max_width = 100,
  }
)
-- customize signature help when pressing gs
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = _G.border,
    title = " (・・ ) ? ",
    -- max_height = 20,
    max_width = _G.floatw,
  }
)
