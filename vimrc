vim9script
set background=dark
filetype plugin indent on
syntax on
set mouse=nvi ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
set showcmd laststatus=2 signcolumn=yes hlsearch
&undodir = $HOME .. "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap <C-c> <ESC>
inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

def SearchComments(): void
    var commentstring: string = &l:commentstring
    var comment_prefix: string = substitute(commentstring, '\s*%s\s*', '', '')
    execute 'lvim /' .. comment_prefix .. '\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope'
enddef

nnoremap gt <scriptcmd>SearchComments()<cr>

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* clearmatches()
    autocmd BufEnter * matchadd('ExtraWhitespace', '\s\+$')
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO <scriptcmd>execute 'lvim /^\(#.*\)\@!\(class\\|\s*def\)/ % \| lope'<cr>
augroup END

def ManShowTOC(): void
  var bufnr: number = bufnr('%')
  var bufname: string = bufname(bufnr)
  var info: dict<any> = getloclist(0, {'winid': 1})

  # Check if location list exists and is associated with current buffer
  if !empty(info) && getwinvar(info.winid, 'qf_toc') ==# bufname
    execute 'lopen'
    return
  endif

  # Initialize table of contents list
  var toc: list<dict<any>> = []
  var lnum: number = 2
  var last_line: number = line('$') - 1
  while lnum > 0 && lnum < last_line
    var text: string = getline(lnum)
    if text =~ '^\s\+[-+]\S' || text =~ '^   \S' || text =~ '^\S'
      add(toc, {
            'bufnr': bufnr,
            'lnum': lnum,
            'text': substitute(substitute(text, '^\s\+', '', ''), '\s\+$', '', '')
            })
    endif
    lnum = nextnonblank(lnum + 1)
  endwhile

  setloclist(0, toc, ' ')
  setloclist(0, [], 'a', {'title': 'Table of contents'})
  execute 'lopen'
  w:qf_toc = bufname
  setlocal filetype=qf
enddef

augroup man
    autocmd!
    autocmd FileType man nnoremap <buffer> <silent> gO <scriptcmd>ManShowTOC()<bar>lope<cr>
augroup END

def SetQuickfixSyntax(): void
    syntax clear
    syntax match qfFileName /^[^│]*/ contained containedin=qfLine
    syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
    syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
    syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
    highlight default link qfFileName Directory
    highlight default link qfLineNr LineNr
    highlight default link qfType Type
enddef

# Define the quickfix text function
def Qftf(info: dict<any>): list<string>
    var items: list<dict<any>> = []
    var ret: list<string> = []

    if info.quickfix
        items = getqflist({'id': info.id, 'items': 0}).items
    else
        items = getloclist(info.winid, {'id': info.id, 'items': 0}).items
    endif

    const limit: number = 31
    for i: number in range(info.start_idx - 1, info.end_idx - 1)
        var e: dict<any> = items[i]
        var fname: string = ''
        var str: string = ''

        if e.valid && info.quickfix
            var qtype: string = empty(e.type) ? '' : ' ' .. toupper(e.type[0])
            if e.bufnr > 0
                fname = bufname(e.bufnr)
                if empty(fname)
                    fname = '[No Name]'
                endif
            endif
            var validFmt: string = '%s | %s'
            str = printf(validFmt, fname, e.text)
        else
            str = e.text
        endif
        add(ret, str)
    endfor

    # Schedule the syntax setup to run asynchronously
    timer_start(0, (_) => SetQuickfixSyntax())
    return ret
enddef

# Set the quickfixtextfunc option
set qftf=Qftf

const data_dir: string = '~/.vim'
if empty(glob(data_dir .. '/autoload/plug.vim'))
  silent execute '!curl -fLo '..data_dir..'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive', { 'on': 'G' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'ku1ik/vim-pasta'
Plug 'neomake/neomake', { 'on': ['Neomake']}
Plug 'markonm/traces.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'on': 'FZF', 'do': { -> fzf#install() } }
Plug 'czheo/mojo.vim', { 'for': 'mojo' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
Plug 'easymotion/vim-easymotion'
Plug 'dense-analysis/ale'
plug#end()

g:ale_linters = { "python": ["ruff"] }
g:ale_lint_on_insert_leave = 0
g:ale_virtualtext_cursor = 0

g:plug_window = 'vertical new'

g:mkdp_open_to_the_world = 1
g:mkdp_echo_preview_url = 1
g:mkdp_port = '8088'

g:fzf_layout = { 'down': '40%' }

g:neoformat_python_ruff = {
    'exe': 'ruff',
    'stdin': 1,
    'args': ['format', '-q', '-'],
}
g:neoformat_enabled_python = ['ruff']
hi SignColumn ctermbg=NONE guibg=NONE
