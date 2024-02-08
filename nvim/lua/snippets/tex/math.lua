local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets, autosnippets = {}, {}

snippets = vim.tbl_extend("force", snippets, {
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  }),
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t("\\beta"),
  }),
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  }),
  s({ trig = "ff", dscr = "Expands `ff` into `\\frac{}{}`" },
    fmta(
      [[\frac{<>}{<>}]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "eq", dscr = "A LaTeX equation environment" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{equation}
          <>
      \end{equation}
      ]],
      -- The insert node is placed in the <> angle brackets
      { i(1) }
    )
  ),
})

return snippets, autosnippets
