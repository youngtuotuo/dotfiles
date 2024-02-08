local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local d = ls.dynamic_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local snippets, autosnippets = {}, {}

snippets = vim.tbl_extend("force", snippets, {
  s({ trig = "tt", dscr = "Expands `tt` into `\\texttt{}`" }, fmta([[\texttt{<>}]], { i(1, "teletype") })),
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
})

return snippets, autosnippets
