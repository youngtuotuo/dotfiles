let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" format
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
" color
Plug 'norcalli/nvim-colorizer.lua'
Plug 'navarasu/onedark.nvim'
" icon
Plug 'kyazdani42/nvim-web-devicons'
" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
" lsp
Plug 'j-hui/fidget.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'neovim/nvim-lspconfig'
" nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'ray-x/cmp-treesitter'
" snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
" TODO
Plug 'folke/todo-comments.nvim'
" zen mode
Plug 'folke/zen-mode.nvim'
" twilight
Plug 'folke/twilight.nvim'
" yank highlight
Plug 'machakann/vim-highlightedyank'
" comment
Plug 'tpope/vim-commentary'
" telescope
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
