local options = {
  autoindent = true,
  backspace = "indent,eol,start",
  backup = false,
  completeopt = "menuone,noinsert,noselect",
  cursorline = false,
  cmdheight = 1,
  errorbells = false,
  expandtab = true,
  fileencoding = "utf-8",
  fillchars = "stl: ,stlnc: ",
  guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  hidden = true,
  hlsearch = false,
  incsearch = true,
  pumheight = 7,
  ignorecase = true,
  laststatus = 3,
  matchtime = 1,
  mouse = "a",
  mousemoveevent = true,
  nu = true,
  rnu = true,
  ru = true,
  scrolloff = 5,
  shiftwidth = 4,
  showcmd = true,
  showmatch = false,
  showmode = true,
  signcolumn = "auto:2",
  smartcase = true,
  smartindent = false,
  softtabstop = 4,
  splitbelow = true,
  splitright = true,
  splitkeep = "screen",
  swapfile = false,
  updatetime = 50,
  undofile = true,
  viminfo = "'1000",
  visualbell = false,
  wrap = true,
  writebackup = false,
}
if vim.env.TERM == "nsterm" then
    vim.opt['termguicolors'] = false
elseif vim.env.TERM == "xterm-256color" or vim.env.TERM == "tmux-256color" then
    vim.opt['termguicolors'] = true
end


for k, v in pairs(options) do
  vim.opt[k] = v
end

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

vim.cmd([[
    augroup vimrc-incsearch-highlight
      autocmd!
      autocmd CmdlineEnter /,\? :set hlsearch
      autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
]])

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
