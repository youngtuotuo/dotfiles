return {
  "RRethy/vim-illuminate",
  ft = { "json", "python", "sh", "lua", "c", "cpp", "cuda", "zig" },
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
