vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
local mojo = "mojo"
local cmd = mojo .. " %"
cmd = ":sp | terminal " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
