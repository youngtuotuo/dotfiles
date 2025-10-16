vim9script
source $VIMRUNTIME/defaults.vim
syntax on
filetype plugin indent on
set mouse=nvi showmatch noswapfile autoread undofile incsearch formatoptions+=jro
set nowrap history=1000 shortmess-=S background=dark termguicolors shiftwidth=4
set expandtab smartindent autoindent scrolloff=5 hlsearch sidescroll=3 sidescrolloff=2
set ttymouse=sgr laststatus=2 cursorline

&t_BE = "\<Esc>[?2004h"
&t_BD = "\<Esc>[?2004l"
&t_PS = "\<Esc>[200~"
&t_PE = "\<Esc>[201~"

&undodir = $HOME .. "/.local/state/vim/undo/"

inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z
nnoremap Y y$
inoremap #T # TODO (mike): 

packadd! cfilter
packadd! comment
packadd! nohlsearch
packadd! hlyank
packadd! helptoc


def GetTODO(): void
    var commentstring: string = &l:commentstring
    var comment_prefix: string = substitute(commentstring, "\s*%s\s*", "", "")
    feedkeys(":lvim /" .. comment_prefix .. "\\s*\\(TODO\\|WARN\\|WARNING\\|NOTE\\)/ % | lwindow", "n")
enddef

nnoremap gt <scriptcmd>GetTODO()<cr>

autocmd BufReadPre *.asm g:asmsyntax = "fasm"

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^\(#.*\)\@!\(class\\|\s*def\\|\s*async\sdef\)/ % \| lwindow'<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

augroup c
    autocmd!
    autocmd FileType c setlocal makeprg=cc\ %\ -o\ /dev/null
augroup END

augroup cuda
    autocmd!
    autocmd FileType cuda setlocal makeprg=nvcc\ %\ -o\ /dev/null
    autocmd FileType cuda setlocal errorformat=%f(%l):%m
augroup END

augroup md
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^#\+\(.*\)/ % \| lope'<cr>
    autocmd FileType markdown setlocal expandtab tabstop=4
augroup END
