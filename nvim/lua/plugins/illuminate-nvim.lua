return {
  "RRethy/vim-illuminate",
  dependencies = { "catppuccin" },
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "lazy",
      "markdown"
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
