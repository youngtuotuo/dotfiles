_G.floatw = 110
_G.floath = 50
_G.floatwrap = true

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({ import = "plugins" }, {
  ui = { border = "rounded" },
  change_detection = {
    notify = false,
  },
})

vim.api.nvim_create_user_command("L", "Lazy", {})

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Yank Short Indicator",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.c", "*.cpp", "*.cu" },
  group = group,
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.define = [[^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)]]
    vim.bo.commentstring = [[// %s]]
  end,
  desc = "aucmd for c, cpp",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.html", "*.json", "*.yaml", "*.lua" },
  group = group,
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
  desc = "aucmd for html, json, yaml, lua",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "MakeFile", "*.sh", "Make", "Makefile" },
  group = group,
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = false
  end,
  desc = "aucmd for make and sh",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function()
    vim.opt.indentkeys:remove("<:>")
    vim.opt.formatoptions = "jql"
    vim.treesitter.stop()
  end,
  desc = "All buffer need formatoptions = jql",
})

-- print(vim.inspect(v))
P = function(v)
  print(vim.inspect(v))
  return v
end

--  CHAR        MODE
-- <Space>      Normal, Visual, Select and Operator-pending
-- n            Normal
-- v            Visual and Select
-- s            Select
-- x            Visual
-- o            Operator-pending
-- !            Insert and Command-line
-- i            Insert
-- l            ":lmap" mappings for Insert, Command-line and Lang-Arg
-- c            Command-line
-- t            Terminal-Job

vim.keymap.set(
  { "n" },
  "<C-q>",
  "<nop>",
  { nowait = true, noremap = true, desc = "Never use C-q to enter visual block mode" }
)
vim.keymap.set({ "i" }, "<C-c>", "<nop>", { nowait = true, noremap = true, desc = "Disable interrupt" })
vim.keymap.set({ "i" }, "<C-c>", "<esc>", { noremap = true })
vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true, desc = "Delete back to the first character" })
vim.keymap.set(
  { "n" },
  "c_",
  "c^",
  { nowait = true, noremap = true, desc = "Delete back to the first character and insert" }
)

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true, desc = "let , be undo break points" })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true, desc = "let . be undo break points" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "y, but yank to system clipboard" })

-- More indents options
vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true, desc = "Term mode to normal mode with Esc" })
vim.keymap.set(
  { "n" },
  "<leader>s",
  "<cmd>set invnu invrnu<cr>",
  { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" }
)
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true, desc = "y$, Y like C, D" })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true, desc = "J, but will keep your cursor position" })

vim.keymap.set(
  { "v" },
  "p",
  [["_dP]],
  { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] }
)
vim.keymap.set(
  { "n" },
  "<M-j>",
  "<cmd>move+1<cr>",
  { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" }
)
vim.keymap.set(
  { "v" },
  "J",
  ":move '>+1<CR>gv=gv",
  { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" }
)
vim.keymap.set(
  { "n" },
  "<M-k>",
  "<cmd>move--1<cr>",
  { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" }
)
vim.keymap.set(
  { "v" },
  "K",
  ":move '<-2<CR>gv=gv",
  { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" }
)
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" })

vim.keymap.set({ "n" }, "]p", function()
  vim.cmd([[try | cnext | catch | cfirst | catch | endtry]])
end, { nowait = true, noremap = true, desc = "cnext" })
vim.keymap.set({ "n" }, "[p", function()
  vim.cmd([[try | cprev | catch | clast  | catch | endtry]])
end, { nowait = true, noremap = true, desc = "cprev" })
vim.keymap.set({ "n" }, "<leader>p", function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 and win["loclist"] == 0 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end, { nowait = true, noremap = true, desc = "toggle quickfix window" })

vim.keymap.set({ "n" }, "]l", function()
  vim.cmd([[try | lnext | catch | lfirst | catch | endtry]])
end, { nowait = true, noremap = true, desc = "lnext" })
vim.keymap.set({ "n" }, "[l", function()
  vim.cmd([[try | lprev | catch | llast  | catch | endtry]])
end, { nowait = true, noremap = true, desc = "lprev" })
vim.keymap.set({ "n" }, "<leader>l", function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 and win["loclist"] == 1 then
      vim.cmd.lclose()
      return
    end
  end
  vim.cmd.lopen()
end, { nowait = true, noremap = true, desc = "toggle location list" })

vim.opt.expandtab = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop = 4 -- <BS> delete 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- spaces for auto indent
vim.opt.smartindent = true -- auto indent when typing { & }
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.splitkeep = [[topline]]
vim.opt.completeopt = [[menu,menuone,noselect,preview,fuzzy]]
vim.opt.swapfile = false
vim.opt.updatetime = 50
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.hlsearch = false
if
  (string.find(vim.api.nvim_list_uis()[1].term_name, "xterm%-256color") ~= nil)
  or (string.find(vim.api.nvim_list_uis()[1].term_name, "tmux%-256color") ~= nil)
then
  vim.opt.termguicolors = true
end

vim.opt.grepformat:append({ [[%l:%m]] })
vim.opt.cinkeys:remove(":")

if vim.fn.has("win32") == 1 then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

vim.filetype.add({
  extension = {
    h = "c",
  },
})

vim.cmd.colo [[vim]]
vim.api.nvim_set_hl(0, "CursorLine", { bg = "Grey10", cterm = { underline = true } })
vim.api.nvim_set_hl(0, "Visual", { fg = "none", ctermfg = "none", bg = "NvimLightGrey4", cterm = { underline = true } })
vim.api.nvim_set_hl(0, "Comment", { fg = "NvimDarkGrey4", ctermfg = "darkgrey" })
vim.api.nvim_set_hl(0, "Pmenu", { cterm = { reverse = true }, bg = "NvimDarkGrey3" })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 242, ctermbg = 0, fg = "Black", bg = "DarkGrey" })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })

vim.cmd [[
func! s:focusable_wins() abort
  return filter(nvim_tabpage_list_wins(0), {k,v-> !!nvim_win_get_config(v).focusable})
endf
augroup config_curwin_border
  autocmd!
  highlight CursorLineNC cterm=underdashed gui=underdashed ctermfg=gray guisp=NvimLightGrey4 ctermbg=NONE guibg=NONE
  highlight link WinBorder Statusline

  " Dim non-current cursorline.
  autocmd VimEnter,WinEnter,TabEnter,BufEnter * setlocal winhighlight-=CursorLine:CursorLineNC

  " Highlight curwin WinSeparator/SignColumn for "border" effect.
  let s:winborder_hl = 'WinSeparator:WinBorder,SignColumn:WinBorder'
  autocmd WinLeave * exe 'setlocal winhighlight+=CursorLine:CursorLineNC winhighlight-='..s:winborder_hl
  autocmd WinEnter * exe 'setlocal winhighlight+='..s:winborder_hl
  " Disable effect if there is only 1 window.
  autocmd WinResized * if 1 == len(s:focusable_wins()) | exe 'setlocal winhighlight-='..s:winborder_hl | endif
augroup END
]]
