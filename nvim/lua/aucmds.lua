local group = vim.api.nvim_create_augroup(_G.auG, { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Yank Short Indicator",
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function(opts)
    if opts.file:match("dap%-terminal") then
      return
    end
  end,
  desc = "Enter Terminal with Insert Mode",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.c", "*.cpp" },
  group = group,
  callback = function()
    vim.opt_local.cinoptions = [[=0]]
    vim.opt_local.wildignore:append({ "*.o", "*.obj" })
    vim.opt_local.makeprg = vim.fn.has("win32") == 1 and [[build.bat]] or [[./build.sh]]
    vim.cmd([[compiler gcc]])
  end,
  desc = "aucmd for c/cpp",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.makeprg = [[lua %]]
    vim.keymap.set("v", "<leader>p", ":w !lua")
  end,
  desc = "aucmd for lua",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tex" },
  group = group,
  callback = function()
    vim.opt_local.wildignore:append({ "*.aux", "*.fdb_latexmk", "*.fls", "*.out", "*.synctex.gz" })
  end,
  desc = "aucmd for tex",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  group = group,
  callback = function()
    vim.opt_local.makeprg = [[python3 %]]
    -- :h errorformat
    vim.opt_local.errorformat = [[%A  File "%f"\, line %l%.%#,%Z%[%^ ]%\@=%m]]
    vim.opt_local.wildignore:append({ "*.pyc", "*pycache*", "lib/python*", "lib64/python*" })
    vim.keymap.set("v", "<leader>p", ":w !python3")
  end,
  desc = "aucmd for python",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Makefile" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
  desc = "Change indent to tab for Makefile",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.mojo" },
  group = group,
  callback = function()
    if vim.fn.has("win32") == 0 then
      vim.opt_local.makeprg = [[mojo %]]
      vim.keymap.set("v", "<leader>p", ":w !mojo")
    end
  end,
  desc = "aucmd for mojo",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.html", "*.yaml" },
  group = group,
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "Change indent level to 2 for json, html, yaml",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.rs" },
  group = group,
  callback = function()
    vim.opt_local.makeprg = [[cargo run %]]
    vim.cmd.compiler([[cargo]])
  end,
  desc = "aucmd for rust",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go" },
  group = group,
  callback = function()
    vim.opt_local.makeprg = [[go run %]]
    vim.cmd.compiler([[go]])
  end,
  desc = "aucmd for go",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.zig" },
  group = group,
  callback = function()
    -- vim.g.zig_fmt_autosave = 0
    vim.cmd.compiler([[zig]])
    vim.opt_local.makeprg = [[zig run %]]
  end,
  desc = "aucmd for zig",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.txt" },
  group = group,
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "aucmd for markdown",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function()
    vim.opt.formatoptions = "jql"
  end,
  desc = "All buffer need formatoptions = jql",
})

vim.api.nvim_create_autocmd({ "Syntax", "BufRead" }, {
  pattern = { "*" },
  group = group,
  callback = function()
    vim.fn.matchadd("Todo", [[\v\W\zs<(TODO|LOW)>]], 100)
    vim.fn.matchadd("Debug", [[\v\W\zs<(BUG|MID)>]], 100)
    vim.fn.matchadd("Warn", [[\v\W\zs<(FIX|HIGH)>]], 100)
  end,
  desc = "TODO series",
})
