-- stylua: ignore start
local check_math_h = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.fn.match(content, "math.h") == -1 then
    return false
  end
  return true
end

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

-- event = config[]
local cmds = {
  TextYankPost = { { callback = function() vim.highlight.on_yank() end } },
  TermOpen     = { { callback = function() vim.api.nvim_input("i") end } },
  InsertEnter  = { { callback = function() vim.api.nvim_set_hl(0, "EoLSpace", { bg = "none" }) end } },
  InsertLeave  = { { callback = function() vim.api.nvim_set_hl(0, "EoLSpace", { bg = "NvimLightRed" }) end } },
  BufEnter     = {
    {
      pattern = { "*.c", "*.cpp" },
      callback = function()
        local bufname = vim.fn.expand("%:t:r")
        local bufext = vim.fn.expand("%:e")
        local compiler = vim.fn.has("win32") == 1 and "clang-cl" or (bufext == "c" and "clang" or "clang++")
        local cmd = string.format("%s -Wall -Wextra", compiler)
        -- # include <math.h>
        if check_math_h() then cmd = string.format("%s -l", cmd) end
        --  cpp14
        if bufext == "cpp" then cmd = string.format("%s -std=c++14", cmd) end
        -- compiler -Wall -Wextra -lm -std=c++14 -o fnameEXT && ./fnameEXT
        cmd = string.format("%s -o %s%s %% && .%s%s%s", cmd, bufname, EXT, SEP, bufname, EXT)
        cmd = ":sp | terminal " .. cmd
        vim.keymap.set("n", "<leader>p", cmd)
      end
    },
    {
      pattern = "*",
      callback = function()
        vim.opt.formatoptions = "jql"
      end
    }
  },
  WinLeave = {
    {
      pattern = "*",
      callback = function()
        if vim.o.filetype == "dropbar_menu" then
          vim.opt.guicursor = [[a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]]
        end
      end,
    }
  },
}

for e, configs in pairs(cmds) do
  for _, config in ipairs(configs) do
    config.group = group
    vim.api.nvim_create_autocmd(e, config)
  end
end

return {}
