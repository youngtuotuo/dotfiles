local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "main",
    fmt(
      [[
int main({}) {{
  {}
  return 0;
}}
]],
      {
        c(1, { t(""), t("void"), i(1, "int argc, char *argv[]") }),
        i(2),
      }
    )
  ),
}
