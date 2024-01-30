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
  TextYankPost = { { callback = function() vim.highlight.on_yank() end, desc = "Yank Short Indicator" } },
  TermOpen     = { { callback = function() vim.api.nvim_input("i") end, desc = "Enter Terminal with Insert Mode" } },
  BufEnter     = {
    {
      pattern = { "*.c", "*.cpp" },
      callback = function()
        local bufname = vim.fn.expand("%:t:r")
        local bufext = vim.fn.expand("%:e")
        local compiler = bufext == "c" and "clang" or "clang++"
        local cmd = string.format("%s -Wall -Wextra", compiler)
        -- # include <math.h>
        if check_math_h() then cmd = string.format("%s -lm", cmd) end
        --  cpp14
        if bufext == "cpp" then cmd = string.format("%s -std=c++14", cmd) end
        -- compiler -Wall -Wextra -lm -o fnameEXT && ./fnameEXT
        cmd = string.format("%s -o %s%s %% && ./%s%s", cmd, bufname, _G.ext, bufname, _G.ext)
        cmd = ":sp | terminal " .. cmd
        vim.keymap.set("n", "<leader>p", cmd)
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for c/c++"
    },
    {
      pattern = { "*.lua" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.keymap.set("n", "<leader>p", ":sp | terminal lua %")
        vim.keymap.set("v", "<leader>p", ":w !lua")
      end,
      desc = "<leader>p for lua"
    },
    {
      pattern = { "*.py" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":sp | terminal python3 %")
        vim.keymap.set("v", "<leader>p", ":w !python3")
      end,
      desc = "<leader>p for python"
    },
    {
      pattern = { "Makefile" },
      callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
        vim.opt_local.expandtab = false
      end,
      desc = "Change indent to tab for Makefile"
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
      end,
      desc = "<leader>p for mojo"
    },
    {
      pattern = { "*.json", "*.html", "*.yaml" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
      end,
      desc = "Change indent level to 2 for json, html, yaml"
    },
    {
      pattern = { "*.tex" },
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.keymap.set("n", "<leader>p", ":VimtexCompile")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for latex"
    },
    {
      pattern = { "*.rs" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":sp | terminal cargo run %")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for rust"
    },
    {
      pattern = { "*.go" },
      callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
        vim.opt_local.expandtab = false
        vim.keymap.set("n", "<leader>p", ":sp | terminal go run %")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for go"
    },
    {
      pattern = { "*.zig" },
      callback = function()
        vim.g.zig_fmt_autosave = 0
        vim.keymap.set("n", "<leader>p", ":sp | terminal zig run %")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for zig"
    }
  },
  BufWinEnter = {
    {
      pattern = { "*.txt", "*.md" },
      callback = function()
        if vim.o.filetype == "help" or vim.o.filetype == "markdown" then
          vim.cmd [[wincmd L]]
        end
      end,
      desc = "Let help file go to vertical split"
    },
    {
      callback = function()
        vim.opt.formatoptions = "jql"
      end,
      desc = "All buffer need formatoptions = jql"
    }
  },
  ColorScheme = {
    {
      callback = _G.colorset,
      desc = "Auto set some colors for colorsecheme change"
    }
  },
}

for e, configs in pairs(cmds) do
  for _, config in ipairs(configs) do
    config.group = group
    vim.api.nvim_create_autocmd(e, config)
  end
end
