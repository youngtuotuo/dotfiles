local g = require("tuo.global")
local config = function(capabilities, util)
  return {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = g.border,
        title = " LuaLS ",
        max_width = 100,
        zindex = 500,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = g.border, title = " LuaLS ", max_width = 100 }
      ),
    },
    capabilities = capabilities,
    root_dir = util.root_pattern(unpack({
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    })),
    settings = {
      Lua = {
        runtime = { version = "Lua 5.1" },
        diagnostics = { globals = { "vim", "use" } },
        completion = { callSnippet = "Both" },
        workspace = { checkThirdParty = false },
        semantic = { enable = false },
        hint = { enable = true }
      },
    },
  }
end

return config
