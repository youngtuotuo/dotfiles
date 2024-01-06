local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

local snippets, autosnippets = {}, {}

local sni = s("s", {
  t("AAA"),
  i(1, "text"),
  t"textnode"
}
)
table.insert(snippets, sni)

return snippets, autosnippets
