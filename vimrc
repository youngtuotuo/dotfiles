filetype plugin indent on
syntax on
set mouse=nvi nu rnu ruler showmatch noswapfile autoread undofile
set incsearch ttimeout ttimeoutlen=50 formatoptions+=jro nowrap
set history=10000 shortmess-=S shiftwidth=4 expandtab smartindent
let &undodir=$HOME . "/.local/state/vim/undo/"

runtime ftplugin/man.vim
packadd! matchit cfilter termdebug

inoremap , ,<C-g>u
inoremap . .<C-g>u
nnoremap J mzJ`z

augroup WhitespaceHighlight
    autocmd!
    autocmd ModeChanged *:n call matchadd('ExtraWhitespace', '\s\+$')
    autocmd ModeChanged n:* call clearmatches()
augroup END

highlight ExtraWhitespace ctermbg=9 guibg=LightRed

augroup python_ruff
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gO :lvim /^\(#.*\)\@!\(class\\|\s*def\)/ %<cr>
    autocmd FileType python setlocal makeprg=ruff\ check\ %\ --quiet
    autocmd FileType python setlocal errorformat=%f:%l:%c:\ %m,%-G\ %.%#,%-G%.%#
augroup END

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
    let fnameFmt1 = '%-' . limit . 's'
    let fnameFmt2 = '…%.' . (limit - 1) . 's'
    let validFmt = '%s │%5d:%-3d│%s %s'

    " Process each item in the range
    for i in range(a:info.start_idx - 1, a:info.end_idx - 1)
        let e = items[i]
        let fname = ''
        let str = ''

        if e.valid
            if e.bufnr > 0
                let fname = bufname(e.bufnr)
                if empty(fname)
                    let fname = '[No Name]'
                else
                    let fname = substitute(fname, '^' . $HOME, '~', '')
                endif
                " Truncate fname if too long
                if len(fname) <= limit
                    let fname = printf(fnameFmt1, fname)
                else
                    let fname = printf(fnameFmt2, fname[-limit:])
                endif
            endif
            let lnum = e.lnum > 99999 ? -1 : e.lnum
            let col = e.col > 999 ? -1 : e.col
            let qtype = empty(e.type) ? '' : ' ' . toupper(e.type[0])
            let str = printf(validFmt, fname, lnum, col, qtype, e.text)
        else
            let str = e.text
        endif
        call add(ret, str)
    endfor

    return ret
endfunction

" Set the quickfixtextfunc option
set qftf=function('Qftf')

" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || v:version < 703
  finish
endif
let g:loaded_commentary = 1

function! s:surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! s:strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if l[-1:] ==# ' ' && stridx(a:line . ' ', l) == -1 && stridx(a:line, l[0:-2]) == 0
    let l = l[:-2]
  endif
  if r[0] ==# ' ' && (' ' . a:line)[-strlen(r)-1:] != r && a:line[-strlen(r):] == r[1:]
    let r = r[1:]
  endif
  return [l, r]
endfunction

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l, r] = s:surroundings()
  let uncomment = 2
  let force_uncomment = a:0 > 2 && a:3
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = s:strip_white_space(l,r,line)
    if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  if get(b:, 'commentary_startofline')
    let indent = '^'
  else
    let indent = '^\s*'
  endif

  let lines = []
  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M' . substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '') . '\|' . substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''),
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if force_uncomment
      if line =~ '^\s*' . l
        let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
      endif
    elseif uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),indent).'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call add(lines, line)
  endfor
  call setline(lnum1, lines)
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
  return ''
endfunction

function! s:textobject(inner) abort
  let [l, r] = s:surroundings()
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = s:strip_white_space(l,r,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

command! -range -bar -bang Commentary call s:go(<line1>,<line2>,<bang>0)
xnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>

if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  nmap gcu <Plug>Commentary<Plug>Commentary
endif

nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

" unimpaired.vim - Pairs of handy bracket mappings
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      2.1
" GetLatestVimScripts: 1590 1 :AutoInstall: unimpaired.vim

if exists("g:loaded_unimpaired") || &cp || v:version < 700
  finish
endif
let g:loaded_unimpaired = 1

function! s:Map(...) abort
  let [mode, head, rhs; rest] = a:000
  let flags = get(rest, 0, '') . (rhs =~# '^<Plug>' ? '' : '<script>')
  let tail = ''
  let keys = get(g:, mode.'remap', {})
  if type(keys) == type({}) && !empty(keys)
    while !empty(head) && len(keys)
      if has_key(keys, head)
        let head = keys[head]
        if empty(head)
          let head = '<skip>'
        endif
        break
      endif
      let tail = matchstr(head, '<[^<>]*>$\|.$') . tail
      let head = substitute(head, '<[^<>]*>$\|.$', '', '')
    endwhile
  endif
  if head !=# '<skip>' && empty(maparg(head.tail, mode))
    return mode.'map ' . flags . ' ' . head.tail . ' ' . rhs
  endif
  return ''
endfunction

" Section: Next and previous

function! s:MapNextFamily(map, cmd, current) abort
  let prefix = '<Plug>(unimpaired-' . a:cmd
  let map = '<Plug>unimpaired'.toupper(a:map)
  let cmd = '".(v:count ? v:count : "")."'.a:cmd
  let zv = (a:cmd ==# 'l' || a:cmd ==# 'c' ? 'zv' : '')
  let end = '"<CR>'.zv
  execute 'nnoremap <silent> '.prefix.'previous) :<C-U>exe "'.cmd.'previous'.end
  execute 'nnoremap <silent> '.prefix.'next)     :<C-U>exe "'.cmd.'next'.end
  execute 'nnoremap '.prefix.'first)    :<C-U><C-R>=v:count ? v:count . "' . a:current . '" : "' . a:cmd . 'first"<CR><CR>' . zv
  execute 'nnoremap '.prefix.'last)     :<C-U><C-R>=v:count ? v:count . "' . a:current . '" : "' . a:cmd . 'last"<CR><CR>' . zv
  execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.cmd.'previous'.end
  execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.cmd.'next'.end
  execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.cmd.'first'.end
  execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.cmd.'last'.end
  exe s:Map('n', '['.        a:map , prefix.'previous)')
  exe s:Map('n', ']'.        a:map , prefix.'next)')
  exe s:Map('n', '['.toupper(a:map), prefix.'first)')
  exe s:Map('n', ']'.toupper(a:map), prefix.'last)')
  if a:cmd ==# 'c' || a:cmd ==# 'l'
    execute 'nnoremap <silent> '.prefix.'pfile)  :<C-U>exe "'.cmd.'pfile'.end
    execute 'nnoremap <silent> '.prefix.'nfile)  :<C-U>exe "'.cmd.'nfile'.end
    execute 'nnoremap <silent> '.map.'PFile :<C-U>exe "'.cmd.'pfile'.end
    execute 'nnoremap <silent> '.map.'NFile :<C-U>exe "'.cmd.'nfile'.end
    exe s:Map('n', '[<C-'.toupper(a:map).'>', prefix.'pfile)')
    exe s:Map('n', ']<C-'.toupper(a:map).'>', prefix.'nfile)')
  elseif a:cmd ==# 't'
    nnoremap <silent> <Plug>(unimpaired-ptprevious) :<C-U>exe v:count1 . "ptprevious"<CR>
    nnoremap <silent> <Plug>(unimpaired-ptnext) :<C-U>exe v:count1 . "ptnext"<CR>
    execute 'nnoremap <silent> '.map.'PPrevious :<C-U>exe "p'.cmd.'previous'.end
    execute 'nnoremap <silent> '.map.'PNext :<C-U>exe "p'.cmd.'next'.end
    exe s:Map('n', '[<C-T>', '<Plug>(unimpaired-ptprevious)')
    exe s:Map('n', ']<C-T>', '<Plug>(unimpaired-ptnext)')
  endif
endfunction

call s:MapNextFamily('a', '' , 'argument')
call s:MapNextFamily('b', 'b', 'buffer')
call s:MapNextFamily('l', 'l', 'll')
call s:MapNextFamily('q', 'c', 'cc')
call s:MapNextFamily('t', 't', 'trewind')

function! s:entries(path) abort
  let path = substitute(a:path,'[\\/]$','','')
  let path = substitute(path, '[[$*]', '[&]', 'g')
  let files = split(glob(path."/.*"),"\n")
  let files += split(glob(path."/*"),"\n")
  call map(files,'substitute(v:val,"[\\/]$","","")')
  call filter(files,'v:val !~# "[\\\\/]\\.\\.\\=$"')

  let filter_suffixes = substitute(escape(&suffixes, '~.*$^'), ',', '$\\|', 'g') .'$'
  call filter(files, 'v:val !~# filter_suffixes')

  return sort(files)
endfunction

function! s:FileByOffset(num) abort
  let file = expand('%:p')
  if empty(file)
    let file = getcwd() . '/'
  endif
  let num = a:num
  while num
    let files = s:entries(fnamemodify(file,':h'))
    if a:num < 0
      call reverse(filter(files,'v:val <# file'))
    else
      call filter(files,'v:val ># file')
    endif
    let temp = get(files,0,'')
    if empty(temp)
      let file = fnamemodify(file,':h')
    else
      let file = temp
      let found = 1
      while isdirectory(file)
        let files = s:entries(file)
        if empty(files)
          let found = 0
          break
        endif
        let file = files[num > 0 ? 0 : -1]
      endwhile
      let num += (num > 0 ? -1 : 1) * found
    endif
  endwhile
  return file
endfunction

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

function! s:GetWindow() abort
  if exists('*getwininfo') && exists('*win_getid')
    return get(getwininfo(win_getid()), 0, {})
  else
    return {}
  endif
endfunction

function! s:PreviousFileEntry(count) abort
  let window = s:GetWindow()

  if get(window, 'loclist')
    return 'lolder ' . a:count
  elseif get(window, 'quickfix')
    return 'colder ' . a:count
  else
    return 'edit ' . s:fnameescape(fnamemodify(s:FileByOffset(-v:count1), ':.'))
  endif
endfunction

function! s:NextFileEntry(count) abort
  let window = s:GetWindow()

  if get(window, 'loclist')
    return 'lnewer ' . a:count
  elseif get(window, 'quickfix')
    return 'cnewer ' . a:count
  else
    return 'edit ' . s:fnameescape(fnamemodify(s:FileByOffset(v:count1), ':.'))
  endif
endfunction

nnoremap <silent> <Plug>(unimpaired-directory-next)     :<C-U>execute <SID>NextFileEntry(v:count1)<CR>
nnoremap <silent> <Plug>(unimpaired-directory-previous) :<C-U>execute <SID>PreviousFileEntry(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedDirectoryNext     :<C-U>execute <SID>NextFileEntry(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedDirectoryPrevious :<C-U>execute <SID>PreviousFileEntry(v:count1)<CR>
exe s:Map('n', ']f', '<Plug>(unimpaired-directory-next)')
exe s:Map('n', '[f', '<Plug>(unimpaired-directory-previous)')

" Section: Diff

nnoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>call <SID>Context(1)<CR>
nnoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>call <SID>Context(0)<CR>
vnoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>exe 'normal! gv'<Bar>call <SID>Context(1)<CR>
vnoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>exe 'normal! gv'<Bar>call <SID>Context(0)<CR>
onoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>call <SID>ContextMotion(1)<CR>
onoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>call <SID>ContextMotion(0)<CR>

exe s:Map('n', '[n', '<Plug>(unimpaired-context-previous)')
exe s:Map('n', ']n', '<Plug>(unimpaired-context-next)')
exe s:Map('x', '[n', '<Plug>(unimpaired-context-previous)')
exe s:Map('x', ']n', '<Plug>(unimpaired-context-next)')
exe s:Map('o', '[n', '<Plug>(unimpaired-context-previous)')
exe s:Map('o', ']n', '<Plug>(unimpaired-context-next)')

nnoremap <silent> <Plug>unimpairedContextPrevious :<C-U>call <SID>Context(1)<CR>
nnoremap <silent> <Plug>unimpairedContextNext     :<C-U>call <SID>Context(0)<CR>
xnoremap <silent> <Plug>unimpairedContextPrevious :<C-U>exe 'normal! gv'<Bar>call <SID>Context(1)<CR>
xnoremap <silent> <Plug>unimpairedContextNext     :<C-U>exe 'normal! gv'<Bar>call <SID>Context(0)<CR>
onoremap <silent> <Plug>unimpairedContextPrevious :<C-U>call <SID>ContextMotion(1)<CR>
onoremap <silent> <Plug>unimpairedContextNext     :<C-U>call <SID>ContextMotion(0)<CR>

function! s:Context(reverse) abort
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

function! s:ContextMotion(reverse) abort
  if a:reverse
    -
  endif
  call search('^@@ .* @@\|^diff \|^[<=>|]\{7}[<=>|]\@!', 'bWc')
  if getline('.') =~# '^diff '
    let end = search('^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^@@ '
    let end = search('^@@ .* @@\|^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^=\{7\}'
    +
    let end = search('^>\{7}>\@!', 'Wnc')
  elseif getline('.') =~# '^[<=>|]\{7\}'
    let end = search('^[<=>|]\{7}[<=>|]\@!', 'Wn') - 1
  else
    return
  endif
  if end > line('.')
    execute 'normal! V'.(end - line('.')).'j'
  elseif end == line('.')
    normal! V
  endif
endfunction

" Section: Line operations

function! s:BlankUp() abort
  let cmd = 'put!=repeat(nr2char(10), v:count1)|silent '']+'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-up)", v:count1)'
  endif
  return cmd
endfunction

function! s:BlankDown() abort
  let cmd = 'put =repeat(nr2char(10), v:count1)|silent ''[-'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-down)", v:count1)'
  endif
  return cmd
endfunction

nnoremap <silent> <Plug>(unimpaired-blank-up)   :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> <Plug>(unimpaired-blank-down) :<C-U>exe <SID>BlankDown()<CR>

nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>exe <SID>BlankDown()<CR>

exe s:Map('n', '[<Space>', '<Plug>(unimpaired-blank-up)')
exe s:Map('n', ']<Space>', '<Plug>(unimpaired-blank-down)')

function! s:ExecMove(cmd) abort
  let old_fdm = &foldmethod
  if old_fdm !=# 'manual'
    let &foldmethod = 'manual'
  endif
  normal! m`
  silent! exe a:cmd
  norm! ``
  if old_fdm !=# 'manual'
    let &foldmethod = old_fdm
  endif
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-".a:map.")", a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-up)", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-down)", a:count)
endfunction

nnoremap <silent> <Plug>(unimpaired-move-up)            :<C-U>call <SID>Move('--',v:count1,'up')<CR>
nnoremap <silent> <Plug>(unimpaired-move-down)          :<C-U>call <SID>Move('+',v:count1,'down')<CR>
noremap  <silent> <Plug>(unimpaired-move-selection-up)   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>(unimpaired-move-selection-down) :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

exe s:Map('n', '[e', '<Plug>(unimpaired-move-up)')
exe s:Map('n', ']e', '<Plug>(unimpaired-move-down)')
exe s:Map('x', '[e', '<Plug>(unimpaired-move-selection-up)')
exe s:Map('x', ']e', '<Plug>(unimpaired-move-selection-down)')

" Section: Option toggling

function! s:StatuslineRefresh() abort
  let &l:readonly = &l:readonly
  return ''
endfunction

function! s:Toggle(op) abort
  call s:StatuslineRefresh()
  return eval('&'.a:op) ? 'no'.a:op : a:op
endfunction

function! s:CursorOptions() abort
  return &cursorline && &cursorcolumn ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'
endfunction

function! s:option_map(letter, option, mode) abort
  exe 'nmap <script> <Plug>(unimpaired-enable)' .a:letter ':<C-U>'.a:mode.' '.a:option.'<C-R>=<SID>StatuslineRefresh()<CR><CR>'
  exe 'nmap <script> <Plug>(unimpaired-disable)'.a:letter ':<C-U>'.a:mode.' no'.a:option.'<C-R>=<SID>StatuslineRefresh()<CR><CR>'
  exe 'nmap <script> <Plug>(unimpaired-toggle)' .a:letter ':<C-U>'.a:mode.' <C-R>=<SID>Toggle("'.a:option.'")<CR><CR>'
endfunction

nmap <script> <Plug>(unimpaired-enable)b  :<C-U>set background=light<CR>
nmap <script> <Plug>(unimpaired-disable)b :<C-U>set background=dark<CR>
nmap <script> <Plug>(unimpaired-toggle)b  :<C-U>set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
call s:option_map('c', 'cursorline', 'setlocal')
call s:option_map('-', 'cursorline', 'setlocal')
call s:option_map('_', 'cursorline', 'setlocal')
call s:option_map('u', 'cursorcolumn', 'setlocal')
call s:option_map('<Bar>', 'cursorcolumn', 'setlocal')
nmap <script> <Plug>(unimpaired-enable)d  :<C-U>diffthis<CR>
nmap <script> <Plug>(unimpaired-disable)d :<C-U>diffoff<CR>
nmap <script> <Plug>(unimpaired-toggle)d  :<C-U><C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>
call s:option_map('h', 'hlsearch', 'set')
call s:option_map('i', 'ignorecase', 'set')
call s:option_map('l', 'list', 'setlocal')
call s:option_map('n', 'number', 'setlocal')
call s:option_map('r', 'relativenumber', 'setlocal')
call s:option_map('s', 'spell', 'setlocal')
call s:option_map('w', 'wrap', 'setlocal')
if empty(maparg('<Plug>(unimpaired-toggle)z', 'n'))
  call s:option_map('z', 'spell', 'setlocal')
endif
nmap <script> <Plug>(unimpaired-enable)v  :<C-U>set virtualedit+=all<CR>
nmap <script> <Plug>(unimpaired-disable)v :<C-U>set virtualedit-=all<CR>
nmap <script> <Plug>(unimpaired-toggle)v  :<C-U>set <C-R>=(&virtualedit =~# "all") ? "virtualedit-=all" : "virtualedit+=all"<CR><CR>
nmap <script> <Plug>(unimpaired-enable)x  :<C-U>set cursorline cursorcolumn<CR>
nmap <script> <Plug>(unimpaired-disable)x :<C-U>set nocursorline nocursorcolumn<CR>
nmap <script> <Plug>(unimpaired-toggle)x  :<C-U>set <C-R>=<SID>CursorOptions()<CR><CR>
nmap <script> <Plug>(unimpaired-enable)+  :<C-U>set cursorline cursorcolumn<CR>
nmap <script> <Plug>(unimpaired-disable)+ :<C-U>set nocursorline nocursorcolumn<CR>
nmap <script> <Plug>(unimpaired-toggle)+  :<C-U>set <C-R>=<SID>CursorOptions()<CR><CR>

function! s:ColorColumn(should_clear) abort
  if !empty(&colorcolumn)
    let s:colorcolumn = &colorcolumn
  endif
  return a:should_clear ? '' : get(s:, 'colorcolumn', get(g:, 'unimpaired_colorcolumn', '+1'))
endfunction
nmap <script> <Plug>(unimpaired-enable)t  :<C-U>set colorcolumn=<C-R>=<SID>ColorColumn(0)<CR><CR>
nmap <script> <Plug>(unimpaired-disable)t :<C-U>set colorcolumn=<C-R>=<SID>ColorColumn(1)<CR><CR>
nmap <script> <Plug>(unimpaired-toggle)t  :<C-U>set colorcolumn=<C-R>=<SID>ColorColumn(!empty(&cc))<CR><CR>

exe s:Map('n', 'yo', '<Plug>(unimpaired-toggle)')
exe s:Map('n', '[o', '<Plug>(unimpaired-enable)')
exe s:Map('n', ']o', '<Plug>(unimpaired-disable)')
exe s:Map('n', 'yo<Esc>', '<Nop>')
exe s:Map('n', '[o<Esc>', '<Nop>')
exe s:Map('n', ']o<Esc>', '<Nop>')
exe s:Map('n', '=s', '<Plug>(unimpaired-toggle)')
exe s:Map('n', '<s', '<Plug>(unimpaired-enable)')
exe s:Map('n', '>s', '<Plug>(unimpaired-disable)')
exe s:Map('n', '=s<Esc>', '<Nop>')
exe s:Map('n', '<s<Esc>', '<Nop>')
exe s:Map('n', '>s<Esc>', '<Nop>')

function! s:RestorePaste() abort
  if exists('s:paste')
    let &paste = s:paste
    let &mouse = s:mouse
    unlet s:paste
    unlet s:mouse
  endif
  autocmd! unimpaired_paste
endfunction

function! s:SetupPaste() abort
  let s:paste = &paste
  let s:mouse = &mouse
  set paste
  set mouse=
  augroup unimpaired_paste
    autocmd!
    autocmd InsertLeave * call s:RestorePaste()
    if exists('##ModeChanged')
      autocmd ModeChanged *:n call s:RestorePaste()
    else
      autocmd CursorHold,CursorMoved * call s:RestorePaste()
    endif
  augroup END
endfunction

nnoremap <silent> <Plug>unimpairedPaste :call <SID>SetupPaste()<CR>
nmap <script><silent> <Plug>(unimpaired-paste) :<C-U>call <SID>SetupPaste()<CR>

nmap <script><silent> <Plug>(unimpaired-enable)p  :<C-U>call <SID>SetupPaste()<CR>O
nmap <script><silent> <Plug>(unimpaired-disable)p :<C-U>call <SID>SetupPaste()<CR>o
nmap <script><silent> <Plug>(unimpaired-toggle)p  :<C-U>call <SID>SetupPaste()<CR>0C

" Section: Put

function! s:putline(how, map) abort
  let [body, type] = [getreg(v:register), getregtype(v:register)]
  if type ==# 'V'
    exe 'normal! "'.v:register.a:how
  else
    call setreg(v:register, body, 'l')
    exe 'normal! "'.v:register.a:how
    call setreg(v:register, body, type)
  endif
  silent! call repeat#set("\<Plug>(unimpaired-put-".a:map.")")
endfunction

nnoremap <silent> <Plug>(unimpaired-put-above) :call <SID>putline('[p', 'above')<CR>
nnoremap <silent> <Plug>(unimpaired-put-below) :call <SID>putline(']p', 'below')<CR>
nnoremap <silent> <Plug>(unimpaired-put-above-rightward) :<C-U>call <SID>putline(v:count1 . '[p', 'Above')<CR>>']
nnoremap <silent> <Plug>(unimpaired-put-below-rightward) :<C-U>call <SID>putline(v:count1 . ']p', 'Below')<CR>>']
nnoremap <silent> <Plug>(unimpaired-put-above-leftward)  :<C-U>call <SID>putline(v:count1 . '[p', 'Above')<CR><']
nnoremap <silent> <Plug>(unimpaired-put-below-leftward)  :<C-U>call <SID>putline(v:count1 . ']p', 'Below')<CR><']
nnoremap <silent> <Plug>(unimpaired-put-above-reformat)  :<C-U>call <SID>putline(v:count1 . '[p', 'Above')<CR>=']
nnoremap <silent> <Plug>(unimpaired-put-below-reformat)  :<C-U>call <SID>putline(v:count1 . ']p', 'Below')<CR>=']
nnoremap <silent> <Plug>unimpairedPutAbove :call <SID>putline('[p', 'above')<CR>
nnoremap <silent> <Plug>unimpairedPutBelow :call <SID>putline(']p', 'below')<CR>

exe s:Map('n', '[p', '<Plug>(unimpaired-put-above)')
exe s:Map('n', ']p', '<Plug>(unimpaired-put-below)')
exe s:Map('n', '[P', '<Plug>(unimpaired-put-above)')
exe s:Map('n', ']P', '<Plug>(unimpaired-put-below)')

exe s:Map('n', '>P', "<Plug>(unimpaired-put-above-rightward)")
exe s:Map('n', '>p', "<Plug>(unimpaired-put-below-rightward)")
exe s:Map('n', '<P', "<Plug>(unimpaired-put-above-leftward)")
exe s:Map('n', '<p', "<Plug>(unimpaired-put-below-leftward)")
exe s:Map('n', '=P', "<Plug>(unimpaired-put-above-reformat)")
exe s:Map('n', '=p', "<Plug>(unimpaired-put-below-reformat)")

" Section: Encoding and decoding

function! s:string_encode(str) abort
  let map = {"\n": 'n', "\r": 'r', "\t": 't', "\b": 'b', "\f": '\f', '"': '"', '\': '\'}
  return substitute(a:str,"[\001-\033\\\\\"]",'\="\\".get(map,submatch(0),printf("%03o",char2nr(submatch(0))))','g')
endfunction

function! s:string_decode(str) abort
  let map = {'n': "\n", 'r': "\r", 't': "\t", 'b': "\b", 'f': "\f", 'e': "\e", 'a': "\001", 'v': "\013", "\n": ''}
  let str = a:str
  if str =~# '^\s*".\{-\}\\\@<!\%(\\\\\)*"\s*\n\=$'
    let str = substitute(substitute(str,'^\s*\zs"','',''),'"\ze\s*\n\=$','','')
  endif
  return substitute(str,'\\\(\o\{1,3\}\|x\x\{1,2\}\|u\x\{1,4\}\|.\)','\=get(map,submatch(1),submatch(1) =~? "^[0-9xu]" ? nr2char("0".substitute(submatch(1),"^[Uu]","x","")) : submatch(1))','g')
endfunction

function! s:url_encode(str) abort
  " iconv trick to convert utf-8 bytes to 8bits indiviual char.
  return substitute(iconv(a:str, 'latin1', 'utf-8'),'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! s:url_decode(str) abort
  let str = substitute(substitute(substitute(a:str,'%0[Aa]\n$','%0A',''),'%0[Aa]','\n','g'),'+',' ','g')
  return iconv(substitute(str,'%\(\x\x\)','\=nr2char("0x".submatch(1))','g'), 'utf-8', 'latin1')
endfunction

" HTML entities {{{2

let g:unimpaired_html_entities = {
      \ 'nbsp':     160, 'iexcl':    161, 'cent':     162, 'pound':    163,
      \ 'curren':   164, 'yen':      165, 'brvbar':   166, 'sect':     167,
      \ 'uml':      168, 'copy':     169, 'ordf':     170, 'laquo':    171,
      \ 'not':      172, 'shy':      173, 'reg':      174, 'macr':     175,
      \ 'deg':      176, 'plusmn':   177, 'sup2':     178, 'sup3':     179,
      \ 'acute':    180, 'micro':    181, 'para':     182, 'middot':   183,
      \ 'cedil':    184, 'sup1':     185, 'ordm':     186, 'raquo':    187,
      \ 'frac14':   188, 'frac12':   189, 'frac34':   190, 'iquest':   191,
      \ 'Agrave':   192, 'Aacute':   193, 'Acirc':    194, 'Atilde':   195,
      \ 'Auml':     196, 'Aring':    197, 'AElig':    198, 'Ccedil':   199,
      \ 'Egrave':   200, 'Eacute':   201, 'Ecirc':    202, 'Euml':     203,
      \ 'Igrave':   204, 'Iacute':   205, 'Icirc':    206, 'Iuml':     207,
      \ 'ETH':      208, 'Ntilde':   209, 'Ograve':   210, 'Oacute':   211,
      \ 'Ocirc':    212, 'Otilde':   213, 'Ouml':     214, 'times':    215,
      \ 'Oslash':   216, 'Ugrave':   217, 'Uacute':   218, 'Ucirc':    219,
      \ 'Uuml':     220, 'Yacute':   221, 'THORN':    222, 'szlig':    223,
      \ 'agrave':   224, 'aacute':   225, 'acirc':    226, 'atilde':   227,
      \ 'auml':     228, 'aring':    229, 'aelig':    230, 'ccedil':   231,
      \ 'egrave':   232, 'eacute':   233, 'ecirc':    234, 'euml':     235,
      \ 'igrave':   236, 'iacute':   237, 'icirc':    238, 'iuml':     239,
      \ 'eth':      240, 'ntilde':   241, 'ograve':   242, 'oacute':   243,
      \ 'ocirc':    244, 'otilde':   245, 'ouml':     246, 'divide':   247,
      \ 'oslash':   248, 'ugrave':   249, 'uacute':   250, 'ucirc':    251,
      \ 'uuml':     252, 'yacute':   253, 'thorn':    254, 'yuml':     255,
      \ 'OElig':    338, 'oelig':    339, 'Scaron':   352, 'scaron':   353,
      \ 'Yuml':     376, 'circ':     710, 'tilde':    732, 'ensp':    8194,
      \ 'emsp':    8195, 'thinsp':  8201, 'zwnj':    8204, 'zwj':     8205,
      \ 'lrm':     8206, 'rlm':     8207, 'ndash':   8211, 'mdash':   8212,
      \ 'lsquo':   8216, 'rsquo':   8217, 'sbquo':   8218, 'ldquo':   8220,
      \ 'rdquo':   8221, 'bdquo':   8222, 'dagger':  8224, 'Dagger':  8225,
      \ 'permil':  8240, 'lsaquo':  8249, 'rsaquo':  8250, 'euro':    8364,
      \ 'fnof':     402, 'Alpha':    913, 'Beta':     914, 'Gamma':    915,
      \ 'Delta':    916, 'Epsilon':  917, 'Zeta':     918, 'Eta':      919,
      \ 'Theta':    920, 'Iota':     921, 'Kappa':    922, 'Lambda':   923,
      \ 'Mu':       924, 'Nu':       925, 'Xi':       926, 'Omicron':  927,
      \ 'Pi':       928, 'Rho':      929, 'Sigma':    931, 'Tau':      932,
      \ 'Upsilon':  933, 'Phi':      934, 'Chi':      935, 'Psi':      936,
      \ 'Omega':    937, 'alpha':    945, 'beta':     946, 'gamma':    947,
      \ 'delta':    948, 'epsilon':  949, 'zeta':     950, 'eta':      951,
      \ 'theta':    952, 'iota':     953, 'kappa':    954, 'lambda':   955,
      \ 'mu':       956, 'nu':       957, 'xi':       958, 'omicron':  959,
      \ 'pi':       960, 'rho':      961, 'sigmaf':   962, 'sigma':    963,
      \ 'tau':      964, 'upsilon':  965, 'phi':      966, 'chi':      967,
      \ 'psi':      968, 'omega':    969, 'thetasym': 977, 'upsih':    978,
      \ 'piv':      982, 'bull':    8226, 'hellip':  8230, 'prime':   8242,
      \ 'Prime':   8243, 'oline':   8254, 'frasl':   8260, 'weierp':  8472,
      \ 'image':   8465, 'real':    8476, 'trade':   8482, 'alefsym': 8501,
      \ 'larr':    8592, 'uarr':    8593, 'rarr':    8594, 'darr':    8595,
      \ 'harr':    8596, 'crarr':   8629, 'lArr':    8656, 'uArr':    8657,
      \ 'rArr':    8658, 'dArr':    8659, 'hArr':    8660, 'forall':  8704,
      \ 'part':    8706, 'exist':   8707, 'empty':   8709, 'nabla':   8711,
      \ 'isin':    8712, 'notin':   8713, 'ni':      8715, 'prod':    8719,
      \ 'sum':     8721, 'minus':   8722, 'lowast':  8727, 'radic':   8730,
      \ 'prop':    8733, 'infin':   8734, 'ang':     8736, 'and':     8743,
      \ 'or':      8744, 'cap':     8745, 'cup':     8746, 'int':     8747,
      \ 'there4':  8756, 'sim':     8764, 'cong':    8773, 'asymp':   8776,
      \ 'ne':      8800, 'equiv':   8801, 'le':      8804, 'ge':      8805,
      \ 'sub':     8834, 'sup':     8835, 'nsub':    8836, 'sube':    8838,
      \ 'supe':    8839, 'oplus':   8853, 'otimes':  8855, 'perp':    8869,
      \ 'sdot':    8901, 'lceil':   8968, 'rceil':   8969, 'lfloor':  8970,
      \ 'rfloor':  8971, 'lang':    9001, 'rang':    9002, 'loz':     9674,
      \ 'spades':  9824, 'clubs':   9827, 'hearts':  9829, 'diams':   9830,
      \ 'apos':      39}

" }}}2

function! s:xml_encode(str) abort
  let str = a:str
  let str = substitute(str,'&','\&amp;','g')
  let str = substitute(str,'<','\&lt;','g')
  let str = substitute(str,'>','\&gt;','g')
  let str = substitute(str,'"','\&quot;','g')
  let str = substitute(str,"'",'\&apos;','g')
  return str
endfunction

function! s:xml_entity_decode(str) abort
  let str = substitute(a:str,'\c&#\%(0*38\|x0*26\);','&amp;','g')
  let str = substitute(str,'\c&#\(\d\+\);','\=nr2char(submatch(1))','g')
  let str = substitute(str,'\c&#\(x\x\+\);','\=nr2char("0".submatch(1))','g')
  let str = substitute(str,'\c&apos;',"'",'g')
  let str = substitute(str,'\c&quot;','"','g')
  let str = substitute(str,'\c&gt;','>','g')
  let str = substitute(str,'\c&lt;','<','g')
  let str = substitute(str,'\C&\(\%(amp;\)\@!\w*\);','\=nr2char(get(g:unimpaired_html_entities,submatch(1),63))','g')
  return substitute(str,'\c&amp;','\&','g')
endfunction

function! s:xml_decode(str) abort
  let str = substitute(a:str,'<\%([[:alnum:]-]\+=\%("[^"]*"\|''[^'']*''\)\|.\)\{-\}>','','g')
  return s:xml_entity_decode(str)
endfunction

function! s:Transform(algorithm,type) abort
  let sel_save = &selection
  let cb_save = &clipboard
  set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
  let reg_save = exists('*getreginfo') ? getreginfo('@') : getreg('@')
  if a:type ==# 'line'
    silent exe "normal! '[V']y"
    let @@ = substitute(@@, "\n$", '', '')
  elseif a:type ==# 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif
  if a:algorithm =~# '^\u\|#'
    let @@ = {a:algorithm}(@@)
  else
    let @@ = s:{a:algorithm}(@@)
  endif
  norm! gvp
  call setreg('@', reg_save)
  let &selection = sel_save
  let &clipboard = cb_save
endfunction

function! s:TransformOpfunc(type) abort
  return s:Transform(s:encode_algorithm, a:type)
endfunction

function! s:TransformSetup(algorithm) abort
  let s:encode_algorithm = a:algorithm
  let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'TransformOpfunc'
  return 'g@'
endfunction

function! UnimpairedMapTransform(algorithm, key) abort
  let name = tr(a:algorithm, '_', '-')
  exe 'nnoremap <expr> <Plug>unimpaired_'    .a:algorithm.' <SID>TransformSetup("'.a:algorithm.'")'
  exe 'xnoremap <expr> <Plug>unimpaired_'    .a:algorithm.' <SID>TransformSetup("'.a:algorithm.'")'
  exe 'nnoremap <expr> <Plug>unimpaired_line_'.a:algorithm.' <SID>TransformSetup("'.a:algorithm.'")."_"'
  exe 'nnoremap <expr> <Plug>(unimpaired-' . name . ') <SID>TransformSetup("'.a:algorithm.'")'
  exe 'xnoremap <expr> <Plug>(unimpaired-' . name . ') <SID>TransformSetup("'.a:algorithm.'")'
  exe 'nnoremap <expr> <Plug>(unimpaired-' . name . '-line) <SID>TransformSetup("'.a:algorithm.'")."_"'
  exe s:Map('n', a:key, '<Plug>(unimpaired-' . name . ')')
  exe s:Map('x', a:key, '<Plug>(unimpaired-' . name . ')')
  exe s:Map('n', a:key.a:key[strlen(a:key)-1], '<Plug>(unimpaired-' . name . '-line)')
  return ''
endfunction

exe UnimpairedMapTransform('string_encode','[y')
exe UnimpairedMapTransform('string_decode',']y')
exe UnimpairedMapTransform('string_encode','[C')
exe UnimpairedMapTransform('string_decode',']C')
exe UnimpairedMapTransform('url_encode','[u')
exe UnimpairedMapTransform('url_decode',']u')
exe UnimpairedMapTransform('xml_encode','[x')
exe UnimpairedMapTransform('xml_decode',']x')

" vim:set sw=2 sts=2:

if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfLineNr LineNr
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn
hi def link qfInfo DiagnosticInfo
hi def link qfNote DiagnosticHint

let b:current_syntax = 'qf'
