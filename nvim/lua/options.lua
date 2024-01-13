local options = {
  expandtab = true,
  softtabstop = 4,
  shiftwidth = 4,
  smartindent = true,
  termsync = false,
  wrap = false,
  cinoptions = "l1", -- for switch, case alignment
  writebackup = false, -- no need this with undo history plugin
  completeopt = "menu,menuone,noinsert,noselect",
  guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  laststatus = 3,
  -- search
  hlsearch = false,
  ignorecase = true, -- Ignore case when searching...
  smartcase = true, -- ... unless there is a capital letter in the query
  matchtime = 1, -- display of current match paren faster
  showmatch = true, -- show matching brackets when text indicator is over them
  mouse = "a",
  mousemoveevent = true,
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

-- stylua: ignore start
for k, v in pairs(options) do vim.opt[k] = v end

if vim.o.laststatus == 0 then
  vim.opt.statusline = "%{repeat('─',winwidth('.'))}"
end


vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,]")
vim.opt.undodir = vim.fn.stdpath("data") .. string.format("%sundodir%s", SEP, SEP)
if vim.fn.has("win32") == 1 then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

vim.g.netrw_altfile = 1
vim.g.netrw_cursor = 5
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_hide = 0

-- illusions that I can type fast without any typo
for _, c in ipairs({"w", "x", "q"}) do
  -- W, X, Q
  vim.api.nvim_create_user_command(c:upper(), c, { bang = true, bar = true })
  for _, a in ipairs({"", "a", "A"}) do
    -- Wa, Xa, Qa, WA, XA, QA
    vim.api.nvim_create_user_command(c:upper() .. a,         c .. a, { bang = true, bar = true })
    vim.api.nvim_create_user_command(c:upper() .. a:upper(), c .. a, { bang = true, bar = true })
    if c == "q" then
      -- Wqa, WQa, WqA, WQA
      vim.api.nvim_create_user_command("W" .. c         .. a,         "w" .. c .. a, { bang = true, bar = true })
      vim.api.nvim_create_user_command("W" .. c         .. a:upper(), "w" .. c .. a, { bang = true, bar = true })
      vim.api.nvim_create_user_command("W" .. c:upper() .. a,         "w" .. c .. a, { bang = true, bar = true })
      vim.api.nvim_create_user_command("W" .. c:upper() .. a:upper(), "w" .. c .. a, { bang = true, bar = true })
    end
  end
end
