local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = vim.g.border
  opts.max_width= vim.g.floatw
  opts.wrap = vim.g.floatwrap
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
