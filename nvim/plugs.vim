let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" colorscheme
Plug 'navarasu/onedark.nvim'
Plug 'lourenci/github-colors', { 'branch': 'main' }
Plug 'ellisonleao/glow.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'shaunsingh/nord.nvim'
Plug 'sainnhe/sonokai'
" one of neovim core developer: norcalli@github
Plug 'norcalli/nvim-colorizer.lua'
" git
Plug 'tpope/vim-fugitive'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
" file explorer
Plug 'lambdalisue/glyph-palette.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'SmiteshP/nvim-gps'
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'simrat39/symbols-outline.nvim'
Plug 'kosayoda/nvim-lightbulb'
" lsp color
Plug 'folke/lsp-colors.nvim'
" zen mode
Plug 'folke/zen-mode.nvim'
" yank highlight
Plug 'machakann/vim-highlightedyank'
" comment
Plug 'tpope/vim-commentary'
" telescope
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" registers
" Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
" icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" tmux
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let g:highlightedyank_highlight_duration = 300

runtime ./plugscfg/colorschemecfg.vim
runtime ./plugscfg/treesittercfg.vim
runtime ./plugscfg/icon.vim
runtime ./plugscfg/colorizercfg.vim
runtime ./plugscfg/lspcfg.vim
runtime ./plugscfg/completioncfg.vim
runtime ./plugscfg/telescopecfg.vim
runtime ./plugscfg/indentlinecfg.vim
runtime ./plugscfg/gitsignscfg.vim
runtime ./plugscfg/nvimtreecfg.vim
" runtime ./plugscfg/registerscfg.vim
runtime ./plugscfg/lightbulbcfg.vim
