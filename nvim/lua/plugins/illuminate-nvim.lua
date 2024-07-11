return {
  "RRethy/vim-illuminate",
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
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false })
    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      pattern = { "*" },
      callback = function(ev)
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false })
      end,
    })
  end,
}
