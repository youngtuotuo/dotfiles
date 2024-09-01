require("luasnip.session.snippet_collection").clear_snippets = "python"
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
  s(
    { trig = ";ma", snippetType = "autosnippet" },
    fmta(
      [[
      if __name__ == "__main__":
          <>
      ]],
      {
        d(1, utils.get_visual),
      }
    )
  ),
  s(
    { trig = ";pr", snippetType = "autosnippet" },
    fmta(
      [[
      print(<>)
      ]],
      {
        d(1, utils.get_visual),
      }
    )
  ),
  s(
    { trig = ";pf", snippetType = "autosnippet" },
    fmta(
      [[
      print(f"{<>=}")
      ]],
      {
        d(1, utils.get_visual),
      }
    )
  ),
  s(
    { trig = ";fo", snippetType = "autosnippet" },
    fmta(
      [[
      for <>:
          <>
      ]],
      {
        c(1, {
          sn(nil, { i(1), t(" in "), i(2) }),
          sn(nil, { i(1, "i"), t(" in "), t("range("), i(2), t(")") }),
          sn(nil, { i(1, "idx"), t(", "), i(2, "e"), t(" in "), t("enumerate("), i(3), t(")") }),
        }),
        d(2, utils.get_visual),
      }
    )
  ),
  s(
    { trig = ";if", snippetType = "autosnippet" },
    fmta(
      [[
      if <>:
          <>
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    { trig = ";cf", snippetType = "autosnippet" },
    fmta(
      [[
      <>()
      ]],
      {
        d(1, utils.get_visual),
      }
    )
  ),
  s(
    { trig = ";def", snippetType = "autosnippet" },
    fmta(
      [[
      def <>(<>):
          <>
      ]],
      {
        i(1),
        c(2, {
          sn(nil, { i(1) }),
          sn(nil, { i(1), t(" , *args") }),
          sn(nil, { i(1), t(" , *args, **kwargs") }),
        }),
        i(3),
      }
    )
  ),
  s(
    { trig = ";adef", snippetType = "autosnippet" },
    fmta(
      [[
      async def <>(<>):
          <>
      ]],
      {
        i(1),
        c(2, {
          sn(nil, { i(1) }),
          sn(nil, { i(1), t(" , *args") }),
          sn(nil, { i(1), t(" , *args, **kwargs") }),
        }),
        i(3),
      }
    )
  ),
})

return snippets
