local g = require("tuo.global")
local util = require("vim.lsp.util")

local function split_lines(value)
  value = string.gsub(value, "\\", "")
  value = string.gsub(value, "```cpp", "")
  value = string.gsub(value, "```", "")
  value = string.gsub(value, "`", "")
  return vim.split(value, "\n", { plain = true, trimempty = true })
end

local function convert_input_to_markdown_lines(input, contents)
  contents = contents or {}
  -- MarkedString variation 1
  if type(input) == "string" then
    vim.list_extend(contents, split_lines(input))
  else
    assert(type(input) == "table", "Expected a table for LSP input")
    -- MarkupContent
    if input.kind then
      local value = input.value or ""
      vim.list_extend(contents, split_lines(value))
      -- MarkupString variation 2
    elseif input.language then
      -- table.insert(contents, '```' .. input.language)
      vim.list_extend(contents, split_lines(input.value or ""))
      -- table.insert(contents, '```')
      -- By deduction, this must be MarkedString[]
    else
      -- Use our existing logic to handle MarkedString
      for _, marked_string in ipairs(input) do
        convert_input_to_markdown_lines(marked_string, contents)
      end
    end
  end
  if (contents[1] == "" or contents[1] == nil) and #contents == 1 then
    return {}
  end
  return contents
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
  local contents ---@type string[]
  contents = convert_input_to_markdown_lines(result.contents)
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  return util.open_floating_preview(contents, "plaintext", config)
end

local config = function(capabilities, util)
  return {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(hover, {
        border = g.border,
        title = " Clangd ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Signature ", max_width = 100 }
      ),
    },
    capabilities = capabilities,
  }
end

return config
