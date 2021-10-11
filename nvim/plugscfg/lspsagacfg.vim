lua << EOF
local saga = require 'lspsaga'
-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  border_style = "round",
  max_preview_lines = 20,
  finder_action_keys = {
    open = 'o', vsplit = 's',split = 'i',quit = {'<esc>', 'q'},scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  code_action_keys = {
    quit = {'<esc>', 'q'},exec = '<CR>'
  },
  rename_action_keys = {
    quit = {'<esc>', '<C-c>'},exec = '<CR>'  -- quit can be a table
  },
}
EOF
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
"nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> gn :Lspsaga rename<CR>
"nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>
"nnoremap <silent> ga :Lspsaga code_action<CR>
"vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>
