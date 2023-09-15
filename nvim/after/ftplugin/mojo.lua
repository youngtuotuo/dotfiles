vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.cmd [[
  syn keyword mojoKeywords let var inout owned borrowed alias
  syn keyword mojoKeywords struct fn nextgroup=mojoName skipwhite
  syn match mojoName '\h\w*' display contained
  syn match mojoRefName '\h\w*&' display contains=mojoName
  syn region mojoDialect start="`" end="`" display

  hi def link mojoKeywords Keyword
  hi def link mojoRefName Identifier
  hi def link mojoDialect Special
]]
local mojo = "mojo"
local cmd = mojo .. " %"
cmd = ":sp | terminal echo '$ " .. cmd .. "' && " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
