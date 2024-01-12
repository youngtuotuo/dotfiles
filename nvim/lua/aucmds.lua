local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.api.nvim_input("i")
  end,
})

local check_math_h = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.fn.match(content, "math.h") == -1 then
    return false
  end
  return true
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*.c",
  callback = function()
    local fname_next = vim.fn.expand("%:t:r")
    local ext = ""
    local sep = "/"
    local compiler = "clang"
    if vim.fn.has("win32") == 1 then
      ext = ".exe"
      sep = "\\"
      compiler = "clang-cl"
    end
    local cmd = compiler .. " -Wall -Wextra "
    if check_math_h() then
      cmd = cmd .. "-lm "
    end
    cmd = cmd .. "-o " .. fname_next .. ext .. " %"
    cmd = cmd .. " && ." .. sep .. fname_next .. ext
    cmd = ":sp | terminal " .. cmd
    vim.keymap.set("n", "<leader>p", cmd)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*.cpp",
  callback = function()
    local fname_next = vim.fn.expand("%:t:r")
    local ext = ""
    local sep = "/"
    local compiler = "clang++"
    if vim.fn.has("win32") == 1 then
      ext = ".exe"
      sep = "\\"
      compiler = "clang-cl"
    end
    local cmd = compiler .. " -Wall -std=c++14 "
    if check_math_h() then
      cmd = cmd .. "-lm "
    end
    cmd = cmd .. "-o " .. fname_next .. ext .. " %"
    cmd = cmd .. " && ." .. sep .. fname_next .. ext
    cmd = ":sp | terminal " .. cmd
    vim.keymap.set("n", "<leader>p", cmd)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = group,
  callback = function()
    if vim.o.filetype == "dropbar_menu" then
      vim.opt_local.guicursor = "n:ver25,i:block,n:blinkwait1-blinkoff1000-blinkon1-Normal,i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
    else
      vim.opt.formatoptions:remove({ "c", "r", "o" })
    end
    vim.opt.fillchars = "stl: ,stlnc: ,fold: ,foldopen:,foldsep: ,foldclose:"
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  group = group,
  callback = function()
    if vim.o.filetype == "dropbar_menu" then
      vim.opt.guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
    end
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  group = group,
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "EoLSpace", { default = true, bg = "none" })
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "EoLSpace", { default = true, bg = "Red" })
  end,
})
