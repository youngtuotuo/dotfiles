local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local snippets = {}

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- stylua: ignore
snippets = vim.tbl_extend("force", snippets, {
  -- ****************** math *******************
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
  s(
    { trig = "(%A)ff", dscr = "Expands `ff` into `\\frac{}{}`", trigEngine = "pattern" },
    fmta(
      [[<>\frac{<>}{<>}]],
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
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
  s(
    { trig = "(%A)mm", trigEngine = "pattern" },
    fmta([[<>$<>$]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  s(
    { trig = "(%A)ee", trigEngine = "pattern" },
    fmta([[<>e^{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- ****************** fonts *******************
  s(
    { trig = "tt", dscr = "Expands `tt` into `\\texttt{}`" },
    fmta(
      [[\texttt{<>}]],
      { i(1, "teletype") }
    )
  ),
  s(
    { trig = "tii", dscr = "Expands `tii` into `\\textit{}`" },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),
  -- ****************** environments  *******************
  s(
    { trig = "env", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
})

return snippets
