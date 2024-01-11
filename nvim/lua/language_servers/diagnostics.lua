local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    header = true,
    prefix = function()
      return ""
    end,
    focusable = true,
    title = " σ`∀´)σ ",
    border = BORDER,
    max_width = 80,
  },
}

vim.diagnostic.config(diag_config)


