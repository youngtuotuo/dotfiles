-- some useful lua functions

P = function(v)
  print(vim.inspect(v))
  return v
end

local path_sep = "/"
-- :h has() for help
if vim.fn.has("win32") == 1 then
  path_sep = "\\"
end
