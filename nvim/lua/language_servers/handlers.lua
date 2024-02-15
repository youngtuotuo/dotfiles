-- I hate defualt markdown inline hover
local function split_lines(value)
  if vim.o.filetype == "python" then
    value = string.gsub(value, "&nbsp;", " ")
    value = string.gsub(value, "&gt;", ">")
    value = string.gsub(value, "&lt;", "<")
    value = string.gsub(value, "\n\n```", "\n\n```python")
    value = string.gsub(value, "`\\_", "`")
    value = string.gsub(value, "\\%[", "[[")
    value = string.gsub(value, "\\%]", "]]")
    value = string.gsub(value, "(.*)\\_(.*)", "%1_%2")
  elseif vim.o.filetype == "c" or vim.o.filetype == "cpp" then
    value = string.gsub(value, "### ", "")
  end
  if vim.fn.has("win32") == 0 then
    value = string.gsub(value, "\\", "/")
  end
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
  return require("vim.lsp.util").open_floating_preview(
    { split_lines(result.contents.value) },
    result.contents.kind,
    -- "plaintext",
    config
  )
end

local function signature_help(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end
  -- When use `autocmd CompleteDone <silent><buffer> lua vim.lsp.buf.signature_help()` to call signatureHelp handler
  -- If the completion item doesn't have signatures It will make noise. Change to use `print` that can use `<silent>` to ignore
  if not (result and result.signatures and result.signatures[1]) then
    if config.silent ~= true then
      print('No signature help available')
    end
    return
  end
  if result.signatures[1].documentation then
    result.signatures[1].documentation.value = split_lines(result.signatures[1].documentation.value)
  end
  local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
  local triggers = vim.tbl_get(client.server_capabilities, 'signatureHelpProvider', 'triggerCharacters')
  local ft = vim.bo[ctx.bufnr].filetype
  local lines, hl = require("vim.lsp.util").convert_signature_help_to_markdown_lines(result, ft, triggers)
  if not lines or vim.tbl_isempty(lines) then
    if config.silent ~= true then
      print('No signature help available')
    end
    return
  end
  if lines then
    if #lines > 3 then table.remove(lines, #lines) end
    if vim.startswith(lines[1], '```') then table.remove(lines, 1) end
    if vim.startswith(lines[2], '```') then lines[2] = "---" end
  end
  local fbuf, fwin = require("vim.lsp.util").open_floating_preview(lines, 'markdown', config)
  if hl then
    -- Highlight the second line if the signature is wrapped in a Markdown code block.
    vim.api.nvim_buf_add_highlight(fbuf, -1, 'LspSignatureActiveParameter', 0, unpack(hl))
  end
  return fbuf, fwin
end

-- customize hover when pressing K
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  hover,
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
  signature_help,
  {
    border = _G.border,
    title = " (・・ ) ? ",
    -- max_height = 20,
    max_width = _G.floatw,
  }
)
