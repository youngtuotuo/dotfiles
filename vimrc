source $VIMRUNTIME/defaults.vim
set noswapfile autoread undofile formatoptions+=j laststatus=2 ttymouse=sgr
set nowrap shortmess-=S background=dark termguicolors shiftwidth=4 backup
set expandtab smartindent autoindent scrolloff=5 hlsearch sidescroll=3 sidescrolloff=2
let &t_BE = "\<Esc>[?2004h"
let &t_BD = "\<Esc>[?2004l"
let &t_PS = "\<Esc>[200~"
let &t_PE = "\<Esc>[201~"
inoremap <C-u> <C-u><C-g>u
inoremap <C-w> <C-w><C-g>u
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u
inoremap = =<C-g>u
colo evening
