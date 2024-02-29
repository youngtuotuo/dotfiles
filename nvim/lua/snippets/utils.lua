local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local M = {}

M.in_mathzone = function() -- math context detection
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

M.in_text = function()
  return not M.in_mathzone()
end

M.in_comment = function() -- comment detection
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

M.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- A few concrete environments---adapt as needed

M.in_equation = function() -- equation environment detection
  return M.in_env("equation")
end

M.in_itemize = function() -- itemize environment detection
  return M.in_env("itemize")
end

M.in_tikz = function() -- TikZ picture environment detection
  return M.in_env("tikzpicture")
end

M.get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return M
