function! Fileformat()
  return winwidth(0) > 50 ? (WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! Filename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let symbol = WebDevIconsGetFileTypeSymbol() . ' ' . filename
  return &modified ? symbol . ' [+]' : symbol
endfunction

"function! Git() abort
"  let change = get(b:, 'coc_git_status', '')
"  let branch = get(g:, 'coc_git_status', '')
"  return branch !=# '' ? branch . ' ' . change: ''
"endfunction

function! Modified()
  return &modified ? '[+]' : ''
endfunction

function! Encode() abort
  return winwidth(0) > 50 ? &fileencoding : ''
endfunction

let g:coc_status_error_sign = ' '

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'method','filename' ] 
    \           ],
    \   'right': [ [ 'fileformat', 'encode'] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'method', 'filename' ] ],
    \   'right': [ [ 'fileformat', 'encode' ] ]
    \ },
    \ 'component_function': {
    \   'method': 'NearestMethodOrFunction',
    \   'fileformat': 'Fileformat',
    \   'filename': 'Filename',
    \   'encode': 'Encode',
    \   'modified': 'Modified',
    \   },
    \ }
