vim.cmd [[
  let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, AccessModifierOffset: -4}"'],
    \ }
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_lua_luaformat = {
    \ 'exe': 'lua-format',
    \ 'args': ['--column-limit=120'],
    \ }
  let g:neoformat_enabled_lua = ['luaformat']
]]
