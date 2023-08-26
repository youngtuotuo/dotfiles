local cmd = "cargo run %"
cmd = ":13sp | terminal echo '$ " .. cmd .. "' && " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
