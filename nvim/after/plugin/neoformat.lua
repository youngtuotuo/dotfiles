vim.cmd [[
    let g:neoformat_cpp_clangformat = {
        \ 'exe': 'clang-format',
        \ 'args': ['--style="{IndentWidth: 2, AccessModifierOffset: -2}"'],
        \ }
    let g:neoformat_enabled_cpp = ['clangformat']
    let g:neoformat_lua_luaformat = {
        \ 'exe': 'lua-format',
        \ 'args': ['--column-limit=80'],
        \ }
    let g:neoformat_enabled_lua = ['luaformat']
    let g:neoformat_python_black = {
        \ 'exe': 'black',
        \ 'args': ['-l 80'],
        \ 'replace': 1,
        \ }
    let g:neoformat_python_autopep8 = {
        \ 'exe': 'autopep8',
        \ }
    let g:neoformat_python_yapf = {
        \ 'exe': 'yapf',
        \ 'args': ['--style google'],
        \ }
    let g:neoformat_enabled_python = ['black', 'yapf', 'autopep8']
]]
