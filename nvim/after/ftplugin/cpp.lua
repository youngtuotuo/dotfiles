vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
local fname_next = vim.fn.expand("%:t:r")
local ext = ""
local sep = "/"
if vim.fn.has("win32") == 1 then
    ext = ".exe"
    sep = "\\"
end
local cmd = "<cmd>sp | terminal clang++ -Wall -std=c++14 -o " .. fname_next .. ext .. " %"
cmd = cmd .. " && ." .. sep .. fname_next .. ext
vim.keymap.set("n", "<leader>p", cmd)

