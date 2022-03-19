nnoremap <space>f  :Telescope current_buffer_fuzzy_find<CR>
nnoremap <space>b  :Telescope buffers<CR>
nnoremap <space>g  :Telescope git_files<CR>
nnoremap <space>d  :Telescope diagnostics<CR>
nnoremap <space>c  :Telescope commands<CR>
nnoremap <space>h  :Telescope help_tags<CR>
nnoremap <space>m  :Telescope keymaps<CR>
nnoremap <space>t  :TodoTelescope cwd=
nnoremap <space>v  :Telescope lsp_document_symbols<CR>

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
" avoid finger not leave shift
command! W write
command! Q quit
command! X xit
" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>
" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
" bracket complete
inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O
" Enclose (), [], {} in visualmode
vnoremap ( va)<C-o>gvov(<esc>
vnoremap ) va)<C-o>gvov(<esc>
vnoremap [ va]<C-o>gvov[<esc>
vnoremap ] va]<C-o>gvov[<esc>
vnoremap } va}<C-o>gvov{<esc>
vnoremap { va}<C-o>gvov{<esc>
vnoremap ' va'<C-o>gvov'<esc>
vnoremap " va"<C-o>gvov"<esc>

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
nnoremap n nzzzv
nnoremap N Nzzzv
" line moving in normalmode, insertmode, visualmode with autoindent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m -2<CR>==i
inoremap <C-j> <esc>:m +1<CR>==i
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

"Jump list mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count: "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count: "") . 'j'

" ctrl-s to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>
" zenmode
nnoremap <space>z :ZenMode<CR>
" Pane resize
map <S-Up> <C-W>+
map <S-Down> <C-W>-
map <S-Left> <C-W><
map <S-Right> <C-W>>
