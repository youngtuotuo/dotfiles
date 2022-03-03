" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>
" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
" Page naviagtion
map <C-Down> <C-E>
map <C-Up> <C-Y>
map <C-S-Up> <C-U>
map <C-S-Down> <C-D>
" gb tab switch to previous
map gb gT
" Y like C,D
nnoremap Y y$
nnoremap J mzJ`z
" undo breakpoint
inoremap , ,<C-g>u
inoremap ( (<C-g>u
inoremap ) )<C-g>u
inoremap [ [<C-g>u
inoremap ] ]<C-g>u
inoremap { {<C-g>u
inoremap } }<C-g>u
" line moving in normalmode, insertmode, visualmode with autoindent
inoremap <C-k> <esc>:m -2<CR>==i
inoremap <C-j> <esc>:m +1<CR>==i
vnoremap J :m '>+1<CR>gv==gv
vnoremap K :m '<-2<CR>gv==gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" ctrl-o and ctrl-i detect relatively jump
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
" ctrl-v to paste in insertmode
inoremap <C-V> <C-R>"
" ctrl-s to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>
" zenmode
nnoremap <space>z :ZenMode<CR>
" Enclose (), [], {}
vnoremap ( c()<esc>P%
vnoremap ) c()<esc>P%
vnoremap [ c[]<esc>P%
vnoremap ] c[]<esc>P%
vnoremap { c{}<esc>P%
vnoremap } c{}<esc>P%
" Docstring
inoremap """ """<CR>"""<esc>kA
" Pane resize
map <S-Up> <C-W>+
map <S-Down> <C-W>-
map <S-Left> <C-W><
map <S-Right> <C-W>>
