return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_method = "(has('win32') ? 'general':'siokey')"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-xelatex",
      }
      vim.g.vimtex_quickfix_enabled = 0
      vim.g.vimtex_imaps_enabled = 0
    end,
  },
}
