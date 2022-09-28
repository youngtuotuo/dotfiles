local path_sep = "/"
-- :h has() for help
if vim.fn.has("win32") == 1 then
  path_sep = "\\"
end

vim.g.startup_bookmarks = {
  ["i"] = vim.fn.stdpath('config') .. path_sep .. 'init.lua',
}
require("startup").setup({ theme = "Startify" })
