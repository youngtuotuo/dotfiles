let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" color
Plug 'jonathanfilip/vim-lucius'
" stablizer
Plug 'luukvbaal/stabilize.nvim'
" netrw the pope
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
" formatter
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" git
Plug 'tpope/vim-fugitive'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
" lsp
Plug 'onsails/lspkind-nvim'
Plug 'neovim/nvim-lspconfig'
" nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'ray-x/cmp-treesitter'
" snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app &&  yarn install'}
" TODO
Plug 'folke/todo-comments.nvim'
" comment
Plug 'tpope/vim-commentary'
" telescope
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
