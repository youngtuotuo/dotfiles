let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" one of neovim core developer: norcalli@github
Plug 'norcalli/nvim-colorizer.lua'
" git
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
" lsp tree structure
Plug 'liuchengxu/vista.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
" lsp & treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'folke/lsp-colors.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
" yank highlight
Plug 'machakann/vim-highlightedyank'
" telescope
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" icons
Plug 'ryanoasis/vim-devicons'
" colorscheme
Plug 'navarasu/onedark.nvim'
" syntax highlight
"Plug 'sheerun/vim-polyglot'
" tmux
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let g:highlightedyank_highlight_duration = 300

runtime ./plugscfg/onedarkcfg.vim
runtime ./plugscfg/telescopecfg.vim
runtime ./plugscfg/vistacfg.vim
runtime ./plugscfg/indentlinecfg.vim
runtime ./plugscfg/colorizedcfg.vim
runtime ./plugscfg/treesittercfg.vim
runtime ./plugscfg/completioncfg.vim
runtime ./plugscfg/lspcfg.vim
runtime ./plugscfg/lspcolorcfg.vim
