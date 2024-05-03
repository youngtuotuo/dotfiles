return {
  "RRethy/vim-illuminate",
  dependencies = { "catppuccin" },
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex"
    }
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end
}
