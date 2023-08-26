local py = "python3"
if vim.fn.has("win32") == 1 then
  py = "python"
end
local cmd = py .. " %"
cmd = ":13sp | terminal echo '$ " .. cmd .. "' && " .. cmd
vim.keymap.set("n", "<leader>p", cmd)
