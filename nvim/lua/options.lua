local options = {
  expandtab = true,
  softtabstop = 4,
  shiftwidth = 4,
  smartindent = true,
  termsync = false,
  wrap = false,
  cinoptions="l1", -- for switch, case alignment
  writebackup = false, -- no need this with undo history plugin
  completeopt = "menu,menuone,noinsert,noselect",
  guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- all block with blink
  -- search
  hlsearch = false,
  ignorecase = true, -- Ignore case when searching...
  smartcase = true, -- ... unless there is a capital letter in the query
  matchtime = 1, -- display of current match paren faster
  showmatch = true, -- show matching brackets when text indicator is over them
  mouse = "a",
  mousemodel = "extend",
  nu = false,
  rnu = false,
  ru = true,
  scrolloff = 10,
  termguicolors = true,
  showcmd = true,
  showmode = true,
  signcolumn = "yes:1",
  splitbelow = true,
  splitright = true,
  splitkeep = "screen",
  swapfile = false,
  updatetime = 50,
  undofile = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,]")
vim.opt.undodir = vim.fn.stdpath("data") .. string.format("%sundodir%s", SEP, SEP)

-- highlight group for trailing white space
vim.cmd([[
  highlight default EoLSpace guibg=Red
  match EoLSpace /\s\+$/
  autocmd InsertEnter * hi EoLSpace guibg=NONE
  autocmd InsertLeave * hi EoLSpace guibg=Red
]])

local yank_augroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd([[startinsert]])
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
    vim.opt.fillchars = "stl: ,stlnc: ,fold: ,foldopen:,foldsep: ,foldclose:"
  end,
})

if vim.fn.has("win32") == 1 then
  vim.cmd([[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]])
end

vim.g.netrw_altfile = 1
vim.g.netrw_cursor = 5
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_hide = 0

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
