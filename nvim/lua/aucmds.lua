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

local function netrw_yank_path()
  local path = vim.b.netrw_curdir .. "/" .. vim.fn.expand("<cfile>")
  local abs_path = vim.fn.fnamemodify(path, ":p")
  vim.fn.setreg('"', abs_path)
  print("Yanked: " .. abs_path)
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "yp", netrw_yank_path, { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = _G.group,
  callback = _G.set_highlights})
