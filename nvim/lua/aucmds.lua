local group = vim.api.nvim_create_augroup(_G.group, { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Yank Short Indicator",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.c", "*.cpp" },
  group = group,
  callback = function()
    vim.opt_local.cinoptions = [[=0]]
    vim.opt_local.define = [[^\s*#\s*define]]
    vim.opt_local.commentstring = [[// %s]]
  end,
  desc = "aucmd for c/cpp",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "aucmd for lua",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  group = group,
  callback = function()
    -- :h errorformat
    vim.opt_local.errorformat = [[%A  File "%f"\, line %l%.%#,%Z%[%^ ]%\@=%m]]
    vim.keymap.set({ "n" }, "'<space>", ":term python %", { noremap = true, desc = "Run with term command" })
  end,
  desc = "aucmd for python",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Makefile", "*.sh" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
  desc = "Change indent to tab for Makefile",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.html", "*.yaml" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.indentkeys:remove("<:>")
  end,
  desc = "Change indent level to 2 for json, html, yaml",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function()
    vim.opt.indentkeys:remove("<:>")
    vim.opt.formatoptions = "jql"
  end,
  desc = "All buffer need formatoptions = jql",
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#cccccc" })
  end,
  desc = "All buffer need formatoptions = jql",
})
