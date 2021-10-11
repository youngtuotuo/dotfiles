let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" git
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
" lsp tree structure
Plug 'liuchengxu/vista.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
" lsp & treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'jasonrhansen/lspsaga.nvim', {'branch': 'finder-preview-fixes'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/completion-nvim'
Plug 'folke/lsp-colors.nvim'
" telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" icons
Plug 'ryanoasis/vim-devicons'
" status bar
"Plug 'itchyny/lightline.vim'
" colorscheme
Plug 'joshdick/onedark.vim'
" session control
Plug 'rmagatti/auto-session'
" syntax highlight
Plug 'sheerun/vim-polyglot'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" fzf
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

runtime ./plugscfg/onedarkcfg.vim
runtime ./plugscfg/telescopecfg.vim
"runtime ./plugscfg/coccfg.vim
"runtime ./plugscfg/lightlinecfg.vim
runtime ./plugscfg/vistacfg.vim
runtime ./plugscfg/indentlinecfg.vim
runtime ./plugscfg/completioncfg.vim
"runtime ./plugscfg/treesittercfg.vim
runtime ./plugscfg/lspcfg.vim
"runtime ./plugscfg/lspsagacfg.vim
runtime ./plugscfg/lspcolorcfg.vim
