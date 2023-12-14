local g = require("tuo.global")

local function find_executable_path(executable_name)
  local handle
  if vim.fn.has("win32") then
    handle = io.popen("where " .. executable_name)
  else
    handle = io.popen("which " .. executable_name)
  end
  local result = handle:read("*a")
  handle:close()

  result = result:gsub("\n", "")
  -- result = result:gsub("\\", "/")

  return result
end

local config = function(capabilities, util)
  return {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
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
    -- cmd = {
    --   "clangd", "--query-driver=" .. find_executable_path("gcc")-- .. "," .. find_executable_path("clang++") .. "," .. find_executable_path("gcc") .. "," .. find_executable_path("g++")
    -- }
  }
end

return config

