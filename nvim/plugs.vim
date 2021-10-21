let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" one of neovim core developer: norcalli@github
Plug 'norcalli/nvim-colorizer.lua'
" git
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}
Plug 'nvim-treesitter/playground'
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
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
" colorscheme
Plug 'navarasu/onedark.nvim'
" syntax highlight
" Plug 'sheerun/vim-polyglot'
" tmux
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let g:highlightedyank_highlight_duration = 300

runtime ./plugscfg/onedarkcfg.vim
runtime ./plugscfg/lspcfg.vim
runtime ./plugscfg/completioncfg.vim
runtime ./plugscfg/treesittercfg.vim
runtime ./plugscfg/telescopecfg.vim
runtime ./plugscfg/indentlinecfg.vim
runtime ./plugscfg/colorizedcfg.vim
runtime ./plugscfg/icon.vim

lua << EOF
require("zen-mode").setup()
require("zen-mode").toggle({
  window = {
    width = .5 -- width will be 50% of the editor width
  }
})
EOF
