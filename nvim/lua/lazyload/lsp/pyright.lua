local g = require("tuo.global")
local util = require('vim.lsp.util')

local function split_lines(value)
  value = string.gsub(value, '\r\n?', '\n')
  value = string.gsub(value, '&nbsp;', ' ')
  value = string.gsub(value, '\\', '')
  return vim.split(value, '\n', { plain = true, trimempty = true })
end

local function convert_input_to_markdown_lines(input, contents)
  contents = contents or {}
  -- MarkedString variation 1
  if type(input) == 'string' then
    vim.list_extend(contents, split_lines(input))
  else
    assert(type(input) == 'table', 'Expected a table for LSP input')
    -- MarkupContent
    if input.kind then
      local value = input.value or ''
      vim.list_extend(contents, split_lines(value))
      -- MarkupString variation 2
    elseif input.language then
      table.insert(contents, '```' .. input.language)
      vim.list_extend(contents, split_lines(input.value or ''))
      table.insert(contents, '```')
      -- By deduction, this must be MarkedString[]
    else
      -- Use our existing logic to handle MarkedString
      for _, marked_string in ipairs(input) do
        convert_input_to_markdown_lines(marked_string, contents)
      end
    end
  end
  if (contents[1] == '' or contents[1] == nil) and #contents == 1 then
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
      vim.notify('No information available')
    end
    return
  end
  local format = 'markdown'
  local contents ---@type string[]
  if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
    format = 'plaintext'
    contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
  else
    contents = convert_input_to_markdown_lines(result.contents)
  end
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify('No information available')
    end
    return
  end
  return util.open_floating_preview(contents, format, config)
end


local config = function(capabilities, util)
  return {
    handlers = {
      ["textDocument/publishDiagnostics"] = function() end,
      ["textDocument/hover"] = vim.lsp.with(hover, {
        border = g.border,
        title = " Pyright ",
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " Pyright ", max_width = 100 }
      ),
    },
    capabilities =  capabilities,
    root_dir = util.root_pattern(unpack({
      ".gitignore",
      "pyproject.toml",
    })),
    settings = {
      pyright = {
        -- Disables the “Organize Imports” command. This is useful if you are using another extension that provides similar functionality and you don’t want the two extensions to fight each other.
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
          -- Level of logging for Output panel. The default value for this option is "Information".
          -- ["Error", "Warning", "Information", or "Trace"]
          logLevel = "Information",
          -- Determines whether pyright offers auto-import completions.
          autoImportCompletions = true,
          -- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
          autoSearchPaths = false,
          -- Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file. If this option is set to "openFilesOnly", pyright analyzes only open files.
          -- ["off", "openFilesOnly", "workspace"]
          diagnosticMode = "off",
          -- Path to directory containing custom type stub files.
          -- stubPath = {},
          -- Determines the default type-checking level used by pyright. This can be overridden in the configuration file. (Note: This setting used to be called "pyright.typeCheckingMode". The old name is deprecated but is still currently honored.)
          -- ["off", "basic", "strict"]
          typeCheckingMode = "off",
          -- Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files. Type information will typically be incomplete. We recommend using type stubs where possible. The default value for this option is false.
          useLibraryCodeForTypes = true,
        },
      },
    },
  }
end

return config
