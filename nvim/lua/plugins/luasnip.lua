return {
  "L3MON4D3/LuaSnip",
  cond = function()
    return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
  end,
  ft = { "tex", "python" },
  version = "v2.*",
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
    require("luasnip.loaders.from_lua").load({ paths = snippet_path })
    vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
    ls.config.set_config(opts)
    local next_node = function()
      if require("luasnip").jumpable(1) then
        require("luasnip").jump(1)
      end
    end
    local prev_node = function()
      if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      end
    end
    local cycle_choice = function()
      if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
      end
    end
    vim.keymap.set({ "i", "s" }, "<C-n>", next_node, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-p>", prev_node, { silent = true })
    vim.keymap.set({ "i", "s" }, "<Tab>", cycle_choice, { silent = true })
  end,
}
