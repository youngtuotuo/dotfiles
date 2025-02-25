vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]
