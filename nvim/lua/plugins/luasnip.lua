return {
  "L3MON4D3/LuaSnip",
  cond = function()
    return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
  end,
  event = { "BufRead" },
  version = "v2.*",
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  },
  -- stylua: ignore
  keys = {
    {"<C-j>", function() if require("luasnip").jumpable(1) then require("luasnip").jump(1) end end,              silent = true, mode = { "i", "s" }},
    {"<C-k>", function() if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end end,            silent = true, mode = { "i", "s" }},
    {"<C-e>", function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) end end, silent = true, mode = { "i", "s" }},
  },
  config = function(_, opts)
    local ls = require("luasnip")
    local snippet_path = ""
    snippet_path = vim.fn.stdpath("config") .. string.format("%slua%ssnippets%s", vim.g.sep, vim.g.sep, vim.g.sep)
    require("luasnip.loaders.from_lua").load({ paths = snippet_path })
    ls.config.set_config(opts)
  end,
}
