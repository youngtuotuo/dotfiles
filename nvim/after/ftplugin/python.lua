local py = "python3"
if vim.fn.has("win32") == 1 then
  py = "python"
end
local cmd = ":13sp | terminal " .. py .. " %"
vim.keymap.set("n", "<leader>p", cmd)
