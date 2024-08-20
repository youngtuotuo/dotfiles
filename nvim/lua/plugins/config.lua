local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Yank Short Indicator",
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

-- print(vim.inspect(v))
P = function(v)
  print(vim.inspect(v))
  return v
end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
_G.floatw = 70
_G.floath = 30
_G.floatwrap = true

-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

-- stylua: ignore start
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

vim.keymap.set({ "i" }, "<C-p>", "<nop>", { nowait = true, noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "i" }, "<C-n>", "<nop>", { nowait = true, noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "i" }, "<C-c>", "<nop>", { nowait = true, noremap = true, desc = "Disable interrupt" })
vim.keymap.set({ "n" }, "Q",     "<nop>", { nowait = true, noremap = true, desc = "Q repeat the last recorded register [count] times, no need", })
vim.keymap.set({ "n" }, "<C-q>", "<nop>", { nowait = true, noremap = true, desc = "Never use C-q to enter visual block mode" })
vim.keymap.set({ "n" }, "d_",    "d^",    { nowait = true, noremap = true, desc = "Delete back to the first character" })
vim.keymap.set({ "n" }, "c_",    "c^",    { nowait = true, noremap = true, desc = "Delete back to the first character and insert" })

vim.keymap.set({ "i" }, ",",     ",<C-g>u", { noremap = true, desc = "let , be undo break points" })
vim.keymap.set({ "i" }, ".",     ".<C-g>u", { noremap = true, desc = "let . be undo break points" })

vim.keymap.set({ "i" }, "<C-s>", "<C-A>",      { noremap = true, desc = "Try" })
vim.keymap.set({ "c" }, "<C-i>", "<C-l><C-d>", { noremap = true, desc = "I hate menu" })

vim.keymap.set({ "n", "i" }, "<C-c>",     "<esc><cmd>noh<cr>", { noremap = true, desc = "Esc, C-c will raise inetrrutped error" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y',               { noremap = true, desc = "y, but yank to system clipboard" })

-- More indents options
vim.keymap.set({ "i" }, "<S-Tab>",   "<C-d>",                     { noremap = true, desc = "let Shift-Tab go back one indent" })
vim.keymap.set({ "t" }, "<C-[>",     "<C-\\><C-n>",               { noremap = true, desc = "Term mode to normal mode with Esc" })
vim.keymap.set({ "n" }, "<leader>s", "<cmd>set invnu invrnu<cr>", { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" })
vim.keymap.set({ "n" }, "Y",         "y$",                        { noremap = true, desc = "y$, Y like C, D" })
vim.keymap.set({ "n" }, "J",         "mzJ`z",                     { noremap = true, desc = "J, but will keep your cursor position" })

vim.keymap.set({ "v" }, "p",     [["_dP]],              { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] })
vim.keymap.set({ "n" }, "<M-j>", "<cmd>move+1<cr>",     { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" })
vim.keymap.set({ "v" }, "J",     ":move '>+1<CR>gv=gv", { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" })
vim.keymap.set({ "n" }, "<M-k>", "<cmd>move--1<cr>",    { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" })
vim.keymap.set({ "v" }, "K",     ":move '<-2<CR>gv=gv", { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" })
vim.keymap.set({ "v" }, "<",     "<gv",                 { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v" }, ">",     ">gv",                 { noremap = true, desc = ">gv, Move selected line / block of text right" })

vim.keymap.set({ "n" }, "]p", function() vim.cmd([[try | cnext | catch | cfirst | catch | endtry]]) end, { nowait = true, noremap = true, desc = "cnext" })
vim.keymap.set({ "n" }, "[p", function() vim.cmd([[try | cprev | catch | clast  | catch | endtry]]) end, { nowait = true, noremap = true, desc = "cprev" })
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

vim.keymap.set({ "n" }, "]l", function() vim.cmd([[try | lnext | catch | lfirst | catch | endtry]]) end, { nowait = true, noremap = true, desc = "lnext" })
vim.keymap.set({ "n" }, "[l", function() vim.cmd([[try | lprev | catch | llast  | catch | endtry]]) end, { nowait = true, noremap = true, desc = "lprev" })
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

vim.api.nvim_create_user_command("W",   "w",   { bang = true, bar = true })
vim.api.nvim_create_user_command("Q",   "q",   { bang = true, bar = true })
vim.api.nvim_create_user_command("X",   "x",   { bang = true, bar = true })
vim.api.nvim_create_user_command("WQ",  "wq",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Wq",  "wq",  { bang = true, bar = true })
vim.api.nvim_create_user_command("WA",  "wa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Wa",  "wa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("QA",  "qa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Qa",  "qa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("WQA", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("WQa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Wqa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("XA",  "xa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Xa",  "xa",  { bang = true, bar = true })

vim.opt.expandtab = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop = 4 -- <BS> delete 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- spaces for auto indent
vim.opt.smartindent = true -- auto indent when typing { & }
vim.opt.cinoptions = "l1" -- for switch, case alignment, :h cino-l
vim.opt.laststatus = 0
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.guicursor = [[]]
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.updatetime = 50
vim.opt.completeopt = [[menu,menuone,noselect,popup]]
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.virtualedit = "block"
vim.opt.mousemodel = "extend"
vim.opt.formatoptions:remove "o"
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.listchars = [[tab:>-,trail:.]]
vim.opt.list = true
vim.opt.inccommand = "split"

vim.opt.grepformat:append({ [[%l:%m]] })
vim.opt.cinkeys:remove(":")
vim.opt.indentkeys:remove("<:>")
vim.opt.shortmess:append("c")

-- :h netrw-browse-maps
vim.g.netrw_altfile = 1
vim.g.netrw_cursor = 5
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_hide = 0
vim.g.netrw_sizestyle = "h"

if vim.fn.has("win32") == 1 then
  if vim.fn.executable("nu") == 1 then
    vim.opt.shell = "nu"
  else
    vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag =
      "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
  end
end

vim.filetype.add({
  extension = {
    h = "c",
  },
})

return {}
