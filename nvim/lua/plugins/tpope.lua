-- thank you tpope
return {
  {
    "tpope/vim-vinegar",
  },
  {
    "tpope/vim-rsi",
    config = function()
      vim.cmd([[inoremap <expr> <C-E> "\<Lt>End>"]])
    end,
  },
  {
    "tpope/vim-fugitive",
    cond = function()
      local path = vim.loop.cwd() .. "/.git"
      local ok, _ = vim.loop.fs_stat(path)
      if not ok then
        return false
      end
      return true
    end,
    cmd = { "G", "Git" },
  },
}
