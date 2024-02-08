local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

table.insert(snippets,
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  })
)
table.insert(snippets,
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t("\\beta"),
  })
)
table.insert(snippets,
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  })
)
table.insert(snippets,
  s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, {
    t("\\texttt{"), -- remember: backslashes need to be escaped
    i(1),
    t("}"),
  })
)
table.insert(snippets,
  s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" }, {
    t("\\frac{"),
    i(1), -- insert node 1
    t("}{"),
    i(2), -- insert node 2
    t("}"),
  })
)

return snippets, autosnippets
