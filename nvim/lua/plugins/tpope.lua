-- thank you tpope
return {
  {
    "tpope/vim-vinegar",
  },
  {
    "tpope/vim-rsi",
  },
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
  {
    "tpope/vim-dispatch",
    keys = {
      "m<CR>",
      "m<CR>",
      "m<Space>",
      "m!",
      "m?",
      "`<CR>",
      "`<Space>",
      "`!",
      "`?",
      "'<CR>",
      "'<Space>",
      "'!",
      "'?",
      "g'<CR>",
      "g'<Space>",
      "g'!",
      "g'?",
    },
    cmd = { "Dispatch", "Make", "FocusDispatch", "Start", "Spawn" },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
