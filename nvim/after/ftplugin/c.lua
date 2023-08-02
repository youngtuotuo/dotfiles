vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
local fname_next = vim.fn.expand("%:t:r")
local ext = ""
local sep = "/"
local compiler = "clang"
if vim.fn.has("win32") == 1 then
  ext = ".exe"
  sep = "\\"
  compiler = "gcc"
end
local cmd = ":13sp | execute 'terminal " .. compiler .. " -Wall -o " .. fname_next .. ext .. " %"
cmd = cmd .. " && ." .. sep .. fname_next .. ext .. "' | star"
vim.keymap.set("n", "<leader>p", cmd)
