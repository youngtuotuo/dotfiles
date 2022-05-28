" Telescope stuffs
nnoremap <space>r  :Telescope lsp_references<CR>
nnoremap <space>f  :Telescope current_buffer_fuzzy_find<CR>
nnoremap <space>g  :Telescope git_files<CR>
nnoremap <space>d  :Telescope diagnostics<CR>
nnoremap <space>c  :Telescope commands<CR>
nnoremap <space>h  :Telescope help_tags<CR>
nnoremap <space>m  :Telescope keymaps<CR>
nnoremap <space>t  :TodoTelescope cwd=.<CR>
nnoremap <space>v  :Telescope lsp_document_symbols<CR>

" format json
command! FormatJSON %!python -m json.tool

" fixlist
nnoremap co :copen<CR>
nnoremap cc :cclose<CR>
nnoremap cn :cnext<CR>zz
nnoremap cp :cprev<CR>zz

"james powell python3
vnoremap <silent> <leader>p :w !python3<CR>
function! FullPy()
  let b:path=substitute(expand('%:r'), '/', '.', 'g') 
  execute "!" . "python3 -m " . b:path
endfunction
nnoremap <leader>p :call FullPy()<CR>

" g++ compile and execute
nnoremap <leader>g+ :!g++ -o vimpp.out % && ./vimpp.out<CR>
nnoremap <leader>gc :!gcc -o vimc.out % && ./vimc.out<CR>

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
"
" avoid finger not leave shift
command! W write
command! Q quit
command! X xit
"
" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>
"
" Easier pane navigation
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
"
" bracket complete
inoremap {<CR> {<CR>}<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap [<CR> [<CR>]<C-o>O
"
" keep visual block selection
vmap > >gv
vmap < <gv

" Tab navigation like Firefox.
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>
nnoremap tn :tabnew<CR>

" number line
nnoremap <leader>ss :set invnu invrnu<CR>

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
nnoremap <c-s> :w<cr>
vnoremap <c-s> <c-c>:w<cr>
inoremap <c-s> <esc>:w<cr>

" pane resize
map <s-up> <c-w>+
map <s-down> <c-w>-
map <s-left> <c-w><
map <s-right> <c-w>>
" netrw
noremap - :E<CR>
