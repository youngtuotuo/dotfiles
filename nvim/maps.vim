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
" More reasonable remap
" Y like C,D
nnoremap Y y$
" keep cursor centered when navigating
nnoremap { {zz
nnoremap } }zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap J mzJ`z
nnoremap <C-y> <C-y>k^
nnoremap <C-e> <C-e>j^
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
"nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
"nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
" ctrl-v to paste in insertmode
inoremap <C-V> <C-R>"
" indent params in (), [], {} to next line
" don't use this short cut in empty ones
nnoremap <leader>i %di(i<CR><esc>ko<C-R>"<esc>^:w<CR>
nnoremap <leader>o %di[i<CR><esc>ko<C-R>"<esc>^:w<CR>
nnoremap <leader>p %di{i<CR><esc>ko<C-R>"<esc>^:w<CR>
" cut params to new line by ,
nnoremap <leader>, f,a<CR><esc>==<esc>:w<CR>^
" ctrl-s to save
nnoremap <C-s> :w<CR>
" ctrl-q to quit
nnoremap <C-q> :q<CR>
" space-s to source init.vim
nnoremap <space>r :so ~/.config/nvim/init.vim<CR>
" space-t to open integrated terminal
nnoremap <space>t :terminal<CR>
" Enclose (), [], {}, '', ""
vnoremap ( c()<esc>P
vnoremap [ c[]<esc>P
vnoremap { c{}<esc>P
" Docstring
inoremap """ """<CR>"""<esc>kA
" Pane resize
map <S-Up> <C-W>+
map <S-Down> <C-W>-
map <S-Left> <C-W><
map <S-Right> <C-W>>
