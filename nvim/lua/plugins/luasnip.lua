return {
  {
    "L3MON4D3/LuaSnip",
    event = "LspAttach",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
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
        snippet_path = os.getenv(home)
          .. sep
          .. ".config"
          .. sep
          .. "nvim"
          .. sep
          .. "lua"
          .. sep
          .. "snippets"
          .. sep
      end
      -- require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
