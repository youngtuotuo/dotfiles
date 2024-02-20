require("luasnip.session.snippet_collection").clear_snippets = "lua"

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {}

table.insert(
  snippets,
  s(
    "lfuntcion",
    fmt(
      [[
local {} = function({})
  {}
end
]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  )
)

return snippets
