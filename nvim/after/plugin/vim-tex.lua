vim.cmd [[
  let g:vimtex_view_method=(has("win32")?"general":"zathura")
  let g:tex_flavor="latex"
  set conceallevel=2
  let g:vimtex_compiler_latexmk_engines = {
    \ '_' : '-xelatex',
    \}
  let g:vimtex_quickfix_enabled=0
]]
-- Vimtex
vim.api.nvim_set_keymap("n", "<leader>vc", ":VimtexCompile<CR>", {noremap = true, silent = true})
