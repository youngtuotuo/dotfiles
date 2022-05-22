syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
highlight Comment ctermfg=green

"james powell python3
vnoremap <leader>p :w ! python3<CR>
" g++ compile and execute
nnoremap <leader>g+ :!g++ -o vimpp.out % && ./vimpp.out<CR>
nnoremap <leader>gc :!gcc -o vimc.out % && ./vimc.out<CR>


