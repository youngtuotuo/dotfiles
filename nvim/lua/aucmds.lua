local group = vim.api.nvim_create_augroup(_G.auG, { clear = true })

local cmds = {
  TextYankPost = { {
    callback = function()
      vim.highlight.on_yank()
    end,
    desc = "Yank Short Indicator",
  } },
  TermOpen = { {
    callback = function(opts)
      if opts.file:match('dap%-terminal') then
          return
        end
      vim.api.nvim_input("i")
    end,
    desc = "Enter Terminal with Insert Mode",
  } },
  BufEnter = {
    {
      pattern = { "*.c", "*.cpp" },
      callback = function()
        vim.opt_local.cinoptions = [[=0]]
        if vim.fn.has("win32") then
          vim.keymap.set("n", "<leader>p", ":terminal build.bat <C-b>")
        else
          vim.keymap.set("n", "<leader>p", ":terminal ./build.sh <C-b>")
        end
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for c/cpp",
    },
    {
      pattern = { "*.lua" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.keymap.set("n", "<leader>p", ":terminal lua % <C-b>")
        vim.keymap.set("v", "<leader>p", ":w !lua")
      end,
      desc = "<leader>p for lua",
    },
    {
      pattern = { "*.py" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":terminal python3 % <C-b>")
        vim.keymap.set("v", "<leader>p", ":w !python3")
      end,
      desc = "<leader>p for python",
    },
    {
      pattern = { "Makefile" },
      callback = function()
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 0
        vim.opt_local.expandtab = false
      end,
      desc = "Change indent to tab for Makefile",
    },
    {
      pattern = { "*.mojo" },
      callback = function()
        if vim.fn.has("win32") == 0 then
          vim.opt_local.shiftwidth = 4
          vim.opt_local.softtabstop = 4
          vim.keymap.set("n", "<leader>p", ":terminal mojo % <C-b>")
          vim.keymap.set("v", "<leader>p", ":w !mojo")
        end
      end,
      desc = "<leader>p for mojo",
    },
    {
      pattern = { "*.json", "*.html", "*.yaml" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
      end,
      desc = "Change indent level to 2 for json, html, yaml",
    },
    {
      pattern = { "*.tex" },
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.keymap.set("n", "<leader>p", ":VimtexCompile")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for latex",
    },
    {
      pattern = { "*.rs" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":terminal cargo run % <C-b>")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for rust",
    },
    {
      pattern = { "*.go" },
      callback = function()
        vim.keymap.set("n", "<leader>p", ":terminal go run % <C-b>")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for go",
    },
    {
      pattern = { "*.zig" },
      callback = function()
        vim.g.zig_fmt_autosave = 0
        vim.keymap.set("n", "<leader>p", ":terminal zig run % <C-b>")
        vim.keymap.set("v", "<leader>p", "<nop>")
      end,
      desc = "<leader>p for zig",
    },
    {
      pattern = { "*.md" },
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
      desc = "local markdown conceallevel",
    },
  },
  BufWinEnter = {
    {
      callback = function()
        vim.opt.formatoptions = "jql"
      end,
      desc = "All buffer need formatoptions = jql",
    },
  },
  ColorScheme = {
    {
      callback = _G.colorset,
      desc = "Auto set some colors for colorsecheme change",
    },
  },
}

for e, configs in pairs(cmds) do
  for _, config in ipairs(configs) do
    config.group = group
    vim.api.nvim_create_autocmd(e, config)
  end
end
