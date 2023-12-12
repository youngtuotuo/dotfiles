local cmd = "go run %"
cmd = ":sp | terminal " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
