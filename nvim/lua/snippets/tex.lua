require("luasnip.session.snippet_collection").clear_snippets = "tex"
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local snippets = {}
local utils = require("snippets.utils")

snippets = vim.tbl_extend("force", snippets, {
  -- ****************** math *******************
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t([[\alpha]]),
  }),
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t([[\beta]]),
  }),
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t([[\gamma]]),
  }),
  s({ trig = ";fa", snippetType = "autosnippet" }, {
    t([[\forall]]),
  }),
  s(
    { trig = "([%$]-);ha", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\hat{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%$]-);mc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\mathcal{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = [[;ff]], snippetType = "autosnippet" },
    fmta([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    })
  ),
  s(
    { trig = ";nn", snippetType = "autosnippet" },
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
    { trig = ";mm", snippetType = "autosnippet" },
    fmta([[$<>$]], {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";ee", snippetType = "autosnippet" },
    fmta([[e^{<>}]], {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),
  -- ****************** fonts *******************
  s(
    { trig = ";tt", dscr = "Expands `tt` into `\\texttt{}`" },
    fmta([[\texttt{<>}]], {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";ti", dscr = "Expands `tii` into `\\textit{}`" },
    fmta("\\textit{<>}", {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";hr" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),
  s(
    { trig = ";rf" },
    fmta([[\ref{<>}]], {
      i(1),
    })
  ),
  -- ****************** environments  *******************
  s(
    { trig = ";env", snippetType = "autosnippet" },
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
  s(
    { trig = ";h1" },
    fmta([[\section{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),
  -- Expand 'dd' into \draw, but only in TikZ environments
  s(
    { trig = ";dd" },
    fmta("\\draw [<>] ", {
      i(1, "params"),
    }),
    { condition = utils.in_tikz }
  ),
})

return snippets
