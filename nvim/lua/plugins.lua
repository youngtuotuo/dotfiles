-- Plugins
return require('packer').startup(function()
  -- packer can manage itself
  use { "wbthomason/packer.nvim" }
  -- color
  use { "tjdevries/colorbuddy.vim" }
  use { "tjdevries/gruvbuddy.nvim" }
  use { "norcalli/nvim-colorizer.lua" }
  -- stablizer
  use { "luukvbaal/stabilize.nvim" }
  -- formatter
  use { "sbdchd/neoformat" }
  -- git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  -- treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  use { "nvim-treesitter/nvim-treesitter-textobjects" }
  use { "nvim-treesitter/playground" }
  use { "nvim-treesitter/nvim-treesitter-context" }
  -- lsp
  use { "onsails/lspkind-nvim" }
  use { "neovim/nvim-lspconfig" }
  -- nvim-cmp
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  -- snippet
  use { "L3MON4D3/LuaSnip" }
  use { "saadparwaiz1/cmp_luasnip" }
  use { "rafamadriz/friendly-snippets" }
  -- markdown
  use { "iamcco/markdown-preview.nvim", run = 'cd app && yarn install', setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },}
  -- TODO
  use { "folke/todo-comments.nvim" }
  -- comment
  use { "terrortylor/nvim-comment" }
  -- telescope
  use { "nvim-telescope/telescope-fzy-native.nvim", run = 'make' }
  use { "nvim-lua/plenary.nvim" }
  use { "nvim-telescope/telescope.nvim" }
end)
