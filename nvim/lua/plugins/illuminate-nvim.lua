return {
  "RRethy/vim-illuminate",
  dependencies = { "catppuccin" },
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    filetypes_denylist = {},
    filetypes_allowlist = {
      "lua",
      "c",
      "cpp",
      "cuda",
      "python",
      "zig",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
