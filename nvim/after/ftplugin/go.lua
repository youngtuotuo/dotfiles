local cmd = "go run %"
cmd = ":sp | terminal echo '$ " .. cmd .. "' && " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
