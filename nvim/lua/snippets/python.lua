require("luasnip.session.snippet_collection").clear_snippets = "python"

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require("snippets.utils")

local snippets = {}

snippets = vim.tbl_extend("force", snippets, {
  s({ trig = ";pf", snippetType = "autosnippet" },
    fmta(
      [[
      print(f"{<>=}")
      ]],
      { d(1, utils.get_visual) }
    )
  ),
  s({ trig = ";in", snippetType = "autosnippet" },
    fmta(
      [[
      def __init__(self, <>):
          <>
      ]],
      { i(1), i(2) }
    )
  ),
  s({ trig = ";le", snippetType = "autosnippet" },
    fmta(
      [[
      def __len__(self):
          return <>
      ]],
      { i(1) }
    )
  ),
  s({ trig = ";gi", snippetType = "autosnippet" },
    fmta(
      [[
      def __getitem__(self, <>):
          <>
          return <>
      ]],
      { c(1, { t("idx"), i(1) }), i(2), i(3) }
    )
  ),
  s({ trig = ";ma", snippetType = "autosnippet" },
    fmta(
      [[
      if __name__ == "__main__":
          <>
      ]],
      { d(1, utils.get_visual) }
    )
  )

})

return snippets
