local options = {
  expandtab = true,
  softtabstop = 4,
  smartindent = true,
  wrap = true,
  termsync = false,
  showbreak = string.rep(" ", 3),
  linebreak = true,
  -- in case
  belloff = "all",
  cinoptions="l1",
  backspace = "indent,eol,start",
  backup = false,
  completeopt = "menu,menuone,noinsert,noselect",
  errorbells = false,
  equalalways = false,
  fileencoding = "utf-8",
  fillchars = "stl: ,stlnc: ",
  guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  hidden = true,
  -- search
  hlsearch = false,
  incsearch = true, -- Makes search act like search in modern browsers
  ignorecase = true, -- Ignore case when searching...
  matchtime = 1,
  mouse = "a",
  mousemoveevent = true,
  nu = false,
  rnu = false,
  pumheight = 7,
  ru = true,
  smoothscroll = true,
  scrolloff = 10,
  mousemodel = "extend",
  shiftwidth = 4,
  termguicolors = true,
  showcmd = true,
  smartcase = true, -- ... unless there is a capital letter in the query
  showmatch = true, -- show matching brackets when text indicator is over them
  showmode = true,
  signcolumn = "yes:1",
  splitbelow = true,
  splitright = true,
  splitkeep = "screen",
  swapfile = false,
  updatetime = 50,
  undofile = true,
  viminfo = "'1000",
  visualbell = false,
  wildignore = "__pycache__",
  writebackup = false,
  wildmode = "full",
  wildoptions = "pum"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

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
  end,
})
-- vim.opt.formatoptions = vim.opt.formatoptions
--   - "a" -- Auto formatting is BAD.
--   - "t" -- Don't auto format my code. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "q" -- Allow formatting comments w/ gq
--   - "o" -- O and o, don't continue comments
--   + "r" -- But do continue when pressing enter.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   + "j" -- Auto-remove comments if possible.
--   - "2" -- I'm not in gradeschool anymore

local home = "HOME"
local sep = "/"
if vim.fn.has("win32") == 1 then
  home = "USERPROFILE"
  sep = "\\"
  vim.cmd([[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]])
end
vim.opt.undodir = os.getenv(home) .. sep .. ".vim" .. sep .. "undodir"

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