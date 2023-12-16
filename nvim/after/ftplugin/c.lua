vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
local check_math_h = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.fn.match(content, "math.h") == -1 then
    return false
  end
  return true
end

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
