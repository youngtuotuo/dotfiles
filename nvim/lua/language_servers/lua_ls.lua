return {
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
