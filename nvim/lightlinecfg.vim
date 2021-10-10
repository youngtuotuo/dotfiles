function! Fileformat()
  return winwidth(0) > 50 ? (WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! Filename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  return WebDevIconsGetFileTypeSymbol() . ' ' . filename
endfunction

function! Modified()
  return &modified ? '[פֿ]' : ''
endfunction

function! Git() abort
  let change = get(b:, 'coc_git_status', '')
  let branch = get(g:, 'coc_git_status', '')
  return branch !=# '' ? branch . ' ' . change: ''
endfunction

function! Encode() abort
  return winwidth(0) > 50 ? &fileencoding : ''
endfunction

let g:coc_status_error_sign = ' '

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'git', 'cocstatus', 'method','filename', 'modified' ] 
    \           ],
    \   'right': [ [ 'fileformat', 'encode'] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'git', 'cocstatus', 'method', 'filename', 'modified' ] ],
    \   'right': [ [ 'fileformat', 'encode' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'method': 'NearestMethodOrFunction',
    \   'fileformat': 'Fileformat',
    \   'filename': 'Filename',
    \   'git': 'Git',
    \   'encode': 'Encode',
    \   'modified': 'Modified',
    \   },
    \ }
