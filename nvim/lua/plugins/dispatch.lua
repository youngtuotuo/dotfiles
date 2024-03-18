-- m<CR>                   :Make<CR>
-- m<Space>                :Make<Space>
-- m!                      :Make!
-- m?                      Show 'makeprg'
-- `<CR>                   :Dispatch<CR>
-- `<Space>                :Dispatch<Space>
-- `!                      :Dispatch!
-- `?                      :FocusDispatch<CR>
-- '<CR>                   :Start<CR>
-- '<Space>                :Start<Space>
-- '!                      :Start!
-- '?                      Show b:start
-- g'<CR>                  :Spawn<CR>
-- g'<Space>               :Spawn<Space>
-- g'!                     :Spawn!
-- g'?                     Show 'shell'

-- Async :make, :lamek
return {
  "tpope/vim-dispatch",
  event = { "BufEnter" },
}
