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

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

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

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set(
  { "n" },
  "c_",
  "c^",
  { nowait = true, noremap = true }
)

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true })

vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.keymap.set(
  { "v" },
  "p",
  [["_dP]],
  { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] }
)
vim.keymap.set({ "n" }, "<M-j>", "<cmd>move+1<cr>", { noremap = true })
vim.keymap.set(
  { "v" },
  "J",
  ":move '>+1<CR>gv=gv",
  { noremap = true }
)
vim.keymap.set({ "n" }, "<M-k>", "<cmd>move--1<cr>", { noremap = true })
vim.keymap.set(
  { "v" },
  "K",
  ":move '<-2<CR>gv=gv",
  { noremap = true }
)
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true })
vim.keymap.set({ "n" }, "<C-x>c", ":sp|term ", { noremap = true })

vim.keymap.set({ "n" }, "]p", function()
  vim.cmd([[try | cnext | catch | cfirst | catch | endtry]])
end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[p", function()
  vim.cmd([[try | cprev | catch | clast  | catch | endtry]])
end, { nowait = true, noremap = true })

vim.keymap.set({ "n" }, "]l", function()
  vim.cmd([[try | lnext | catch | lfirst | catch | endtry]])
end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[l", function()
  vim.cmd([[try | lprev | catch | llast  | catch | endtry]])
end, { nowait = true, noremap = true })

vim.opt.expandtab = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop = 4 -- <BS> delete 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- spaces for auto indent
vim.opt.smartindent = true -- auto indent when typing { & }
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.completeopt = [[menu,menuone,preview,fuzzy]]
vim.opt.swapfile = false
vim.opt.updatetime = 50
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.listchars = [[tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$]]
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.fillchars:append("vert:|")

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

vim.cmd.colo([[vim]])
vim.api.nvim_set_hl(0, "CursorLine", { bg = "Grey15", ctermbg = 235 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "Yellow", ctermfg = 11 })
vim.api.nvim_set_hl(0, "Visual", { fg = "none", ctermfg = "none", bg = "Grey20", ctermbg = 238 })
vim.api.nvim_set_hl(0, "Comment", { fg = "NvimDarkGrey4", ctermfg = "darkgrey" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NvimDarkGrey3", ctermbg = 239 })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 232, ctermbg = 254, fg = "Black", bg = "DarkGrey" })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none", bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "none", bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })
vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" })
vim.api.nvim_set_hl(0, "VertSplit", { cterm = {reverse = true}, reverse = true })
vim.api.nvim_set_hl(0, "netrwMarkFile", { ctermfg=209, fg=209 })
