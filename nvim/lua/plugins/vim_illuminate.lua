return {
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    opts = {
      providers = {
        "lsp",
        "treesitter",
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "netrw",
      },
    },
    -- stylua: ignore
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.keymap.set( { "n" }, "<c-p>", require("illuminate").goto_prev_reference, { desc = "go to previous reference" })
      vim.keymap.set( { "n" }, "<c-n>", require("illuminate").goto_next_reference, { desc = "go to next reference" })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })
    end,
  },
}
