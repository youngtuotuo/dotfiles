autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_trigger_on_delete = 1
