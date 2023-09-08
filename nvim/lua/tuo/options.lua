local options = {
  -- indent
  autoindent = true,
  cindent = true,
  wrap = true,
  breakindent = true,
  showbreak = string.rep(" ", 3),
  linebreak = true,
  -- in case
  belloff = "all",
  backspace = "indent,eol,start",
  backup = false,
  completeopt = "menuone,noinsert,noselect",
  cmdheight = 1,
  errorbells = false,
  expandtab = true,
  equalalways = false,
  fileencoding = "utf-8",
  fillchars = "stl: ,stlnc: ",
  guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  hidden = true,
  -- search
  hlsearch = true,
  incsearch = true, -- Makes search act like search in modern browsers
  pumheight = 7,
  ignorecase = true, -- Ignore case when searching...
  smartcase = true, -- ... unless there is a capital letter in the query
  laststatus = 3,
  matchtime = 1,
  mouse = "a",
  mousemoveevent = true,
  nu = true,
  rnu = true,
  ru = true,
  smoothscroll = true,
  scrolloff = 10,
  shiftwidth = 4,
  showcmd = true,
  showmatch = true, -- show matching brackets when text indicator is over them
  showmode = true,
  signcolumn = "yes:2",
  smartindent = false,
  softtabstop = 4,
  splitbelow = true,
  splitright = true,
  splitkeep = "screen",
  swapfile = false,
  termguicolors = true,
  updatetime = 50,
  undofile = true,
  viminfo = "'1000",
  visualbell = false,
  wildignore = "__pycache__",
  writebackup = false,
}

vim.opt.pumblend = 17
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })

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
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
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

vim.g.netrw_banner = 0

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

-- Cursorline highlighting control
--  Only have it on in the active buffer
vim.opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
