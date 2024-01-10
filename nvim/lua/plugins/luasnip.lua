return {
  {
    "L3MON4D3/LuaSnip",
    event = "LspAttach",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
      local snippet_path = ""
      snippet_path = vim.fn.stdpath("config") .. string.format("%slua%ssnippets%s", SEP, SEP, SEP)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

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
      vim.keymap.set({ "i", "s" }, "<C-e>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
