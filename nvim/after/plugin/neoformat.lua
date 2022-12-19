vim.cmd [[
  let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"'],
    \ }
  let g:neoformat_enabled_cpp = ['clangformat']
]]
