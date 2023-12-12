local cmd = "cargo run %"
cmd = ":sp | terminal " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
