return {
  "RRethy/vim-illuminate",
  event = "LspAttach",
  -- stylua: ignore
  keys = {
    { "<c-p>", function() require("illuminate").goto_prev_reference() end, { desc = "go to previous reference" } },
    { "<c-n>", function() require("illuminate").goto_next_reference() end, { desc = "go to next reference" } },
  },
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
  config = function(_, opts)
    require("illuminate").configure(opts)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite",{ underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })
  end,
}
