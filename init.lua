vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.winborder = "rounded"

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.lsp.config('*', {
	root_markers = { '.git' },
	offset_encoding = "utf-8"
})

vim.lsp.config.basedpyright = {
	cmd = { 'basedpyright-langserver', '--stdio' },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
				ignore = { "*" }
			},
		},
	}
}

vim.lsp.enable('basedpyright')


vim.lsp.config.ruff = {
	cmd = { 'ruff', 'server' },
	filetypes = { "python" },
	settings = {
		organizeImports = true
	}
}

vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
		end
	end,
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
