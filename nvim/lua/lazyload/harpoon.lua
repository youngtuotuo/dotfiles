require("harpoon").setup()
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>q", require("harpoon.ui").toggle_quick_menu)

for i = 1, 5 do
  vim.keymap.set("n", string.format("<M-%s>", i), function()
    require("harpoon.ui").nav_file(i)
  end, { desc = string.format("require('harpoon.ui').nav_file(%s)", i) })
end
