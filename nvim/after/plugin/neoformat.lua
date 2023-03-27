vim.cmd [[
  let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, AccessModifierOffset: -4}"'],
    \ }
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_lua_luaformat = {
    \ 'exe': 'lua-format',
    \ 'args': ['--column-limit=80'],
    \ }
  let g:neoformat_enabled_lua = ['luaformat']
  let g:neoformat_python_black = {
    \ 'exe': 'black',
    \ 'args': ['-l 120', '-t py38'],
    \ 'replace': 1,
    \ }
  let g:neoformat_enabled_python = ['black']
]]
