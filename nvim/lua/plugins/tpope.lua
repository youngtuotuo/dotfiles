-- thank you tpope
return {
  {
    "tpope/vim-vinegar",
  },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.g.dispatch_no_tmux_make = 1
    end,
  },
  {
    "tpope/vim-rsi",
    config = function()
      vim.cmd([[inoremap <expr> <C-E> "\<Lt>End>"]])
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
