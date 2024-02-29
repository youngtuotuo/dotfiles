require("luasnip.session.snippet_collection").clear_snippets = "python"

local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
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
