vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:n",
    callback = function()
        vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
    end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "n:*",
    callback = function()
        vim.fn.clearmatches()
    end,
})
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = 9, bg = "NvimLightRed" })

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.lsp.config.ruff = {
	cmd = { os.getenv("HOME") .. '/venv/bin/ruff', 'server' },
	root_markers = { 'ruff.toml', '.git' },
	filetypes = { "python" },
	init_options = {
		settings = {
			lineLength = 150,
			lint = {
				ignore = { "E701", "E402", "E712" }
			},
                        interpreter = { os.getenv("HOME") .. "/venv/bin/python3" }
		}
	}
}
vim.lsp.enable('ruff')

vim.diagnostic.config({ virtual_text = { source = true } })
