let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" colorscheme
Plug 'navarasu/onedark.nvim'
Plug 'lourenci/github-colors', { 'branch': 'main' }
Plug 'ellisonleao/glow.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
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
" Plug 'romgrk/nvim-treesitter-context'
Plug 'SmiteshP/nvim-gps'
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/symbols-outline.nvim'
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
" icons
Plug 'ryanoasis/vim-devicons'
" tmux
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let g:highlightedyank_highlight_duration = 300

runtime ./plugscfg/colorcfg.vim
runtime ./plugscfg/treesittercfg.vim
runtime ./plugscfg/icon.vim
runtime ./plugscfg/colorizedcfg.vim
runtime ./plugscfg/lspcfg.vim
runtime ./plugscfg/completioncfg.vim
runtime ./plugscfg/telescopecfg.vim
runtime ./plugscfg/indentlinecfg.vim
runtime ./plugscfg/gitsignscfg.vim
runtime ./plugscfg/nvimtreecfg.vim

lua << EOF
--require("zen-mode").setup()
--require("zen-mode").toggle({
--  window = {
--    width = .7 -- width will be 50% of the editor width
--  }
--})
EOF
augroup my-glyph-palette
  autocmd! *
augroup END
