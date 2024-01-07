local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local snippets, autosnippets = {}, {}

local sni = s({ trig = "auto", regTrig = true }, {
  i(1, "BigGG"),
  rep(1)
})
table.insert(autosnippets, sni)


return snippets, autosnippets
