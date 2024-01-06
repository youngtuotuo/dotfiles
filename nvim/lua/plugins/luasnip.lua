return {
  {
    "L3MON4D3/LuaSnip",
    event = "LspAttach",
    version = "v2.*",
    config = function()
      local home = "HOME"
      local sep = "/"
      local snippet_path = ""
      if vim.fn.has("win32") == 1 then
        home = "USERPROFILE"
        sep = "\\"
        snippet_path = os.getenv(home)
          .. sep
          .. "github"
          .. sep
          .. "dotfiles"
          .. sep
          .. "nvim"
          .. sep
          .. "lua"
          .. sep
          .. "snippets"
          .. sep
      else
        snippet_path = os.getenv(home) .. sep .. ".config/nvim/lua/snippets/"
      end
      -- require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })

      vim.cmd(
        [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
      )
    end,
  },
}
