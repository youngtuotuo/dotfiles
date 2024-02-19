local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets = {}

snippets = vim.tbl_extend("force", snippets, {
  s({ trig = "pff", snippetType = "autosnippet" },
    fmta(
      [[
      print(f"{<>=}")
      ]],
      { i(1) }
    )
  )
})

return snippets

