return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "gitcommit",
          "gitignore",
          "python",
          "c",
          "cpp",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
        },
      })
      vim.cmd [[TSUpdate]]
    end,
  },
}
