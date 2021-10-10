let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
" git
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vista.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
" lsp & treesitter
"Plug 'neovim/nvim-lspconfig'
"Plug 'glepnir/lspsaga.nvim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'
"Plug 'nvim-lua/completion-nvim'
"Plug 'folke/lsp-colors.nvim'
" icons
Plug 'ryanoasis/vim-devicons'
" status bar
Plug 'itchyny/lightline.vim'
" colorscheme
Plug 'joshdick/onedark.vim'
" session control
Plug 'rmagatti/auto-session'
" syntax highlight
Plug 'sheerun/vim-polyglot'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" hide ~ symbol in lasting line
let g:onedark_hide_endofbuffer = 1
if (has("termguicolors"))
  set termguicolors
endif
colorscheme onedark

" python syntax
let g:python_highlight_all = 1

" Vista
let g:vista_sidebar_open_cmd = "30vsplit"
" Executive used when opening vista sidebar without specifying it.
let g:vista_default_executive = 'coc'
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista_sidebar_keepalt = 1
let g:vista#renderer#enable_icon = 1
nnoremap <space>v :Vista!!<CR>

autocmd BufEnter * set indentexpr=
