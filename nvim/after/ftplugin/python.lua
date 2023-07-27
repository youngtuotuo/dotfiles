local py = "python3"
if vim.fn.has("win32") == 1 then
    py = "python"
end
local cmd = "<cmd>sp | terminal " .. py .. " run %<cr>i"
vim.keymap.set("n", "<leader>p", cmd)

