-- stylua: ignore start
local check_math_h = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.fn.match(content, "math.h") == -1 then
    return false
  end
  return true
end

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

local cmds = {
  TextYankPost = { { callback = function() vim.highlight.on_yank() end } },
  TermOpen     = { { callback = function() vim.api.nvim_input("i") end } },
  InsertEnter  = { { callback = function() vim.api.nvim_set_hl(0, "EoLSpace", { bg = "none" }) end } },
  InsertLeave  = {
    {
      callback = function()
        if vim.o.filetype ~= "alpha" or vim.o.buftype ~= "nofile" then
          vim.api.nvim_set_hl(0, "EoLSpace", { bg = "NvimLightRed" })
        end
      end
    },
  },
  BufEnter     = {
    {
      pattern = { "*.c", "*.cpp" },
      callback = function()
        local bufname = vim.fn.expand("%:t:r")
        local bufext = vim.fn.expand("%:e")
        local compiler = vim.fn.has("win32") == 1 and "clang-cl" or (bufext == "c" and "clang" or "clang++")
        local cmd = string.format("%s -Wall -Wextra", compiler)
        -- # include <math.h>
        if check_math_h() then cmd = string.format("%s -lm", cmd) end
        --  cpp14
        if bufext == "cpp" then cmd = string.format("%s -std=c++14", cmd) end
        -- compiler -Wall -Wextra -lm -std=c++14 -o fnameEXT && ./fnameEXT
        cmd = string.format("%s -o %s%s %% && .%s%s%s", cmd, bufname, EXT, SEP, bufname, EXT)
        cmd = ":sp | terminal " .. cmd
        vim.keymap.set("n", "<leader>p", cmd)
        vim.keymap.set("v", "<leader>p", "<nop>")
      end
    },
    {
      pattern = { "*.lua" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.keymap.set("n", "<leader>p", ":sp | terminal lua %")
        vim.keymap.set("v", "<leader>p", ":w !lua")
      end
    },
    {
      pattern = { "*.py" },
      callback = function()
        local py = vim.fn.has("win32") and "python" or "python3"
        vim.keymap.set("n", "<leader>p", string.format(":sp | terminal %s %%", py))
        vim.keymap.set("v", "<leader>p", string.format(":w !%s", py))
      end
    },
    {
      pattern = { "Makefile" },
      callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
        vim.opt_local.expandtab = false
      end
    },
    {
      pattern = { "*.mojo" },
      callback = function()
        if vim.fn.has("win32") == 0 then
          vim.opt_local.shiftwidth = 4
          vim.opt_local.softtabstop = 4
          vim.keymap.set("n", "<leader>p", ":sp | terminal mojo %")
          vim.keymap.set("v", "<leader>p", ":w !mojo")
        end
      end
    },
    {
      pattern = { "*.json", "*.html", "*.yaml" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
      end
    },
    {
      pattern = { "*.tex" },
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.keymap.set("n", "<leader>p", ":VimtexCompile")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end
    },
    {
      pattern = { "*.rs" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":sp | terminal cargo run %")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end
    },
    {
      pattern = { "*.go" },
      callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
        vim.opt_local.expandtab = false
        vim.keymap.set("n", "<leader>p", ":sp | terminal go run %")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end
    },
    {
      pattern = { "*.zig" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        local bufname = vim.fn.expand("%:t:r")
        local bufext = vim.fn.expand("%:e")
        local zig = vim.fn.has("win32") and "zig.exe" or "zig"
        local cmd = string.format(":sp | terminal %s build-exe %s.%s && .%s%s%s", zig, bufname, bufext, SEP, bufname, EXT)
        vim.keymap.set("n", "<leader>p", cmd)
        vim.keymap.set("v", "<leader>p", "<nop>")
      end
    }
  },
  BufWinEnter = {
    {
      pattern = "*.txt",
      callback = function()
        if vim.o.filetype == "help" then
          vim.cmd [[wincmd L]]
        end
      end
    },
  },
  ColorScheme = {
    {
      callback = COLORSET
    }
  }
}

for e, configs in pairs(cmds) do
  for _, config in ipairs(configs) do
    config.group = group
    vim.api.nvim_create_autocmd(e, config)
  end
end
