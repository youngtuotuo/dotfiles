local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = BORDER
  opts.max_width= FLOATW
  opts.wrap = FLOATWRAP
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
