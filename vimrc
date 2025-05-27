set background=dark
filetype plugin indent on
syntax on
set mouse=nvi ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
set showcmd laststatus=2 hlsearch
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap <C-c> <ESC>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

function! s:SearchComments() abort
    let commentstring = &l:commentstring
    let comment_prefix = substitute(commentstring, '\s*%s\s*', '', '')
    execute 'lvim /' . comment_prefix . '\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope'
endfunction
nnoremap gt :call <SID>SearchComments()<CR>

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* call clearmatches()
    autocmd BufEnter * call matchadd('ExtraWhitespace', '\s\+$')
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :lvim /^\(#.*\)\@!\(class\\|\s*def\)/ % \| lope<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

function! ManShowTOC()
  let bufnr = bufnr('%')
  let bufname = bufname(bufnr)
  let info = getloclist(0, {'winid': 1})

  " Check if location list exists and is associated with current buffer
  if !empty(info) && getwinvar(info.winid, 'qf_toc') ==# bufname
    execute 'lopen'
    return
  endif

  " Initialize table of contents list
  let toc = []

  let lnum = 2
  let last_line = line('$') - 1
  while lnum && lnum < last_line
    let text = getline(lnum)
    " Match lines starting with optional whitespace followed by -/+ and non-whitespace,
    " or lines with exactly 3 spaces then non-whitespace,
    " or lines starting with non-whitespace
    if text =~ '^\s\+[-+]\S' || text =~ '^   \S' || text =~ '^\S'
      call add(toc, {
            \ 'bufnr': bufnr,
            \ 'lnum': lnum,
            \ 'text': substitute(substitute(text, '^\s\+', '', ''), '\s\+$', '', '')
            \ })
    endif
    let lnum = nextnonblank(lnum + 1)
  endwhile

  " Set location list with TOC entries
  call setloclist(0, toc, ' ')
  call setloclist(0, [], 'a', {'title': 'Table of contents'})
  execute 'lopen'
  let w:qf_toc = bufname
  " Reload syntax file after setting qf_toc variable
  setlocal filetype=qf
endfunction

augroup man
    autocmd!
    autocmd FileType man nnoremap <buffer> <silent> gO :call ManShowTOC() \| lope<cr>
augroup END

function! s:SetQuickfixSyntax() abort
    " Clear existing quickfix syntax to avoid conflicts
    syntax clear
    " Match filename (up to the separator │)
    syntax match qfFileName /^[^│]*/ contained containedin=qfLine
    " Match line and column numbers (e.g., 123:45)
    syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
    " Match error/warning type (e.g., ' E' or ' W')
    syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
    " Match the entire valid line
    syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
    " Link highlight groups to default quickfix highlights
    highlight default link qfFileName Directory
    highlight default link qfLineNr LineNr
    highlight default link qfType Type
endfunction

" Define the quickfix text function
function! Qftf(info) abort
    let items = []
    let ret = []

    " Determine if it's a quickfix or location list
    if a:info.quickfix
        let items = getqflist({'id': a:info.id, 'items': 0}).items
    else
        let items = getloclist(a:info.winid, {'id': a:info.id, 'items': 0}).items
    endif

    " Formatting constants
    let limit = 31

    " Process each item in the range
    for i in range(a:info.start_idx - 1, a:info.end_idx - 1)
        let e = items[i]
        let fname = ''
        let str = ''

        if e.valid && a:info.quickfix
            let qtype = empty(e.type) ? '' : ' ' . toupper(e.type[0])
            if e.bufnr > 0
                let fname = bufname(e.bufnr)
                if empty(fname)
                    let fname = '[No Name]'
                endif
            endif
            let validFmt = '%s | %s'
            let str = printf(validFmt, fname, e.text)
        else
            let str = e.text
        endif
        call add(ret, str)
    endfor

    " Schedule the syntax setup to run asynchronously
    call timer_start(0, {-> s:SetQuickfixSyntax()})
    return ret
endfunction

" Set the quickfixtextfunc option
set qftf=function('Qftf')

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive', { 'on': 'G' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-vividchalk'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-vinegar'
Plug 'ku1ik/vim-pasta'
Plug 'neomake/neomake', { 'on': ['Neomake']}
Plug 'markonm/traces.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']}
Plug 'iamcco/markdown-preview.nvim', { 'on': 'MarkdownPreview', 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'on': 'FZF', 'do': { -> fzf#install() } }
Plug 'czheo/mojo.vim', { 'for': 'mojo' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
Plug 'easymotion/vim-easymotion'
call plug#end()

let g:plug_window = 'vertical new'

let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_port = '8088'

let g:fzf_layout = { 'down': '40%' }

let g:neoformat_enabled_python = ['ruff']
colo vividchalk
