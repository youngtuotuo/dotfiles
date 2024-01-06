local M = {}

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
  return value
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
  local value = split_lines(result.contents.value)
  return require("vim.lsp.util").open_floating_preview({ value }, result.contents.kind, config)
end

function M.setup()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(hover, {
    border = BORDER,
    title = " Hover ",
    max_width = 100,
    zindex = 500,
    focusable = true,
  })
end

return M
