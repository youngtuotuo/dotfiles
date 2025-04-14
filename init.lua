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
vim.o.winborder = "rounded"

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.lsp.config.basedpyright = {
	cmd = { "basedpyright-langserver", "--stdio" },
	root_markers = { "pyproject.toml", ".git" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				ignore = { "*" }
			},
			disableOrganizeImports = true
		},
	}
}
vim.lsp.enable("basedpyright")

vim.lsp.config.ruff = {
	cmd = { 'ruff', 'server' },
	root_markers = { 'ruff.toml', '.git' },
	filetypes = { "python" },
	settings = {
		lineLength = 150,
		lint = {
			ignore = { "E701", "E402", "E712" }
		}
	}
}
vim.lsp.enable('ruff')

vim.diagnostic.config({ virtual_lines = { current_line = false } })
