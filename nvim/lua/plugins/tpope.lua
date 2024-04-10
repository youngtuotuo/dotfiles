-- thank you tpope
return {
  {
    "tpope/vim-rsi",
    config = function()
      vim.cmd [[inoremap <expr> <C-E> "\<Lt>End>"]]
    end
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
