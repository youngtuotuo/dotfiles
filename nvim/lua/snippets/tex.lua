require("luasnip.session.snippet_collection").clear_snippets = "tex"
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local snippets = {}
local utils = require("snippets.utils")

snippets = vim.tbl_extend("force", snippets, {
  -- ****************** math *******************
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s({ trig = ";ap", snippetType = "autosnippet" }, {
    t([[\alpha]]),
  }),
  s({ trig = ";ld", snippetType = "autosnippet" }, {
    t([[\lambda]]),
  }),
  s({ trig = ";be", snippetType = "autosnippet" }, {
    t([[\beta]]),
  }),
  s({ trig = ";ga", snippetType = "autosnippet" }, {
    t([[\gamma]]),
  }),
  s({ trig = ";dt", snippetType = "autosnippet" }, {
    t([[\delta]]),
  }),
  s({ trig = ";Dt", snippetType = "autosnippet" }, {
    t([[\Delta]]),
  }),
  s({ trig = ";si", snippetType = "autosnippet" }, {
    t([[\sigma]]),
  }),
  s({ trig = ";pr", snippetType = "autosnippet" }, {
    t([[\prod]]),
  }),
  s({ trig = ";th", snippetType = "autosnippet" }, {
    t([[\theta]]),
  }),
  s({ trig = ";su", snippetType = "autosnippet" }, {
    t([[\sum]]),
  }),
  s({ trig = ";ma", snippetType = "autosnippet" }, {
    t([[\max]]),
  }),
  s({ trig = ";fa", snippetType = "autosnippet" }, {
    t([[\forall]]),
  }),
  s({ trig = ";pa", snippetType = "autosnippet" }, {
    t([[\partial]]),
  }),
  s(
    { trig = ";equ", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[\<>]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("geq"), t("leq"), t("equiv"), t("approx") }) }
    )
  ),
  s(
    { trig = ";rar", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[\<>]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("rightarrow"), t("longrightarrow") }) }
    )
  ),
  s(
    { trig = ";lar", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[\<>]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("leftarrow"), t("longleftarrow") }) }
    )
  ),
  s(
    { trig = ";ic", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[\<>]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("subset"), t("subseteq"), t("nsubseteq"), t("not\\subset"), t("subsetneq"), t("subsetneqq") }) }
    )
  ),
  s({ trig = ";ift", snippetType = "autosnippet" }, {
    t([[\infty]]),
  }),
  s({ trig = ";iff", snippetType = "autosnippet" }, {
    t([[\iff]]),
  }),
  s(
    { trig = "([%$]-);sq", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\sqrt{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%$]-);ba", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\bar{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
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
    { trig = "([%$]-);td", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\tilde{<>}]], {
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
    { trig = "([%$]-);mr", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\mathrm{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%$]-);on", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\operatorname{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%$]-);mf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\mathbf{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = "([%$]-);mb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\mathbb{<>}]], {
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
    { trig = "([%$]-);bp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<> <>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        sn(nil, { t("\\left( "), d(1, utils.get_visual), t(" \\right)")}),
        sn(nil, { t("\\left[ "), d(1, utils.get_visual), t(" \\right]")}),
        sn(nil, { t("\\left{ "), d(1, utils.get_visual), t(" \\right}")})
      }),
    })
  ),
  s(
    { trig = ";eqq", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{<>}
           <>
      \end{<>}
      ]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("equation"), t("equation*") }), d(2, utils.get_visual), rep(1) }
    )
  ),
  s(
    { trig = ";qu", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{displayquote}
           <>
      \end{displayquote}
      ]],
      -- The insert node is placed in the <> angle brackets
      { d(1, utils.get_visual) }
    )
  ),
  s(
    { trig = ";al", snippetType = "autosnippet" },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{<>}
           <>
      \end{<>}
      ]],
      -- The insert node is placed in the <> angle brackets
      { c(1, { t("align"), t("align*") }), i(2), rep(1) }
    )
  ),
  s(
    { trig = ";mm", snippetType = "autosnippet" },
    fmta([[$ <> $]], {
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
    { trig = "([%a%)%]%}|])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),
  s(
    { trig = "([%a%)%]%}|])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),
  -- ****************** fonts *******************
  s(
    { trig = ";tt", snippetType = "autosnippet" },
    fmta([[\texttt{<>}]], {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";ti", snippetType = "autosnippet" },
    fmta("\\textit{<>}", {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";tb", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", {
      d(1, utils.get_visual),
    })
  ),
  s(
    { trig = ";hr", snippetType = "autosnippet" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),
  s(
    { trig = ";rf", snippetType = "autosnippet" },
    fmta([[\ref{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ";lb", snippetType = "autosnippet" },
    fmta([[\label{<>}]], {
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
        rep(1),
      }
    )
  ),
  s(
    { trig = ";se", snippetType = "autosnippet" },
    fmta([[\<>{<>}]], { c(1, { t("section"), t("section*") }), d(2, utils.get_visual) }),
    { condition = line_begin }
  ),
  s(
    { trig = ";sb", snippetType = "autosnippet" },
    fmta([[\<>{<>}]], { c(1, { t("subsection"), t("subsection*") }), d(2, utils.get_visual) }),
    { condition = line_begin }
  ),
  s(
    { trig = ";ssb", snippetType = "autosnippet" },
    fmta([[\<>{<>}]], { c(1, { t("subsubsection"), t("subsubsection*") }), d(2, utils.get_visual) }),
    { condition = line_begin }
  ),
  -- templates
  s(
    { trig = ";newa", snippetType = "autosnippet" },
    fmta(
      [[
    \documentclass{article}
    \usepackage[a4paper]{geometry}
    \usepackage[utf8]{inputenc}
    \usepackage{indentfirst}
    %list code
    \usepackage{listings}
    %content include references
    \usepackage[nottoc,numbib]{tocbibind}
    % table of contents clickabel
    \usepackage{hyperref}
    % make file system neat and easier to manage
    \usepackage{subfiles}
    % packages
    \usepackage{csquotes}
    \usepackage{arydshln}
    \usepackage{dsfont}
    \usepackage{polynom}
    \usepackage{empheq}
    \usepackage{calc}
    \usepackage{enumitem}
    \usepackage{graphicx}
    \usepackage{systeme}
    \usepackage{mathtools}
    \usepackage{tikz}
    \usepackage{amsfonts, mathrsfs, bm, amsmath, amssymb, bbm, amsthm}
    \usepackage{ifthen}
    \usepackage{enumerate}
    % Make the preview part more eye friendly
    \usepackage{xcolor}
    \pagecolor[rgb]{1,1,1} % background
    \color[rgb]{0,0,0} % foreground
    % new command
    \DeclareMathOperator*{\argmax}{arg max}
    \DeclareMathOperator*{\argmin}{arg min}
    % theorem block
    \newtheorem{theorem}{Theorem}[section]
    \newtheorem{note}{Note}
    % cross page equation
    \allowdisplaybreaks

    \begin{document}
        <>
    \end{document}
    ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),
})

return snippets
