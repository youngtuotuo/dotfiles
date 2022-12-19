require("mason").setup()
-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = {'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua', 'texlab'}

-- Ensure the servers above are installed
require('mason-lspconfig').setup {ensure_installed = servers}

-- Turn on lsp status information
require('fidget').setup()
