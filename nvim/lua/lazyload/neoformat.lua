vim.g.neoformat_cpp_clangformat = {
    exe='clang-format',
    args= {'--style="{IndentWidth: 2, AccessModifierOffset: -2}"'},
}
vim.g.neoformat_enabled_cpp = {'clangformat'}
vim.g.neoformat_lua_luaformat = {
    exe ='lua-format',
    args = {'--column-limit=80'},
}
vim.g.neoformat_enabled_lua = {'luaformat'}
vim.g.neoformat_python_black = {
    exe = 'black',
    args = {'-l 80'},
    replace = 1,
}
vim.g.neoformat_python_autopep8 = {
    exe = 'autopep8',
}
vim.g.neoformat_python_yapf = {
    exe = 'yapf',
    args = {'--style google'},
}
vim.g.neoformat_enabled_python = {'black', 'yapf', 'autopep8'}
