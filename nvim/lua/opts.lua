-- stylua: ignore start
local options = {
  expandtab   = true, -- <Tab> to space char, CTRL-V-I to insert real tab 
  softtabstop = 4, -- <BS> delete 4 spaces
  tabstop     = 4,
  shiftwidth  = 4, -- spaces for auto indent
  smartindent = true, -- auto indent when typing { & }
  cinoptions  = "l1", -- for switch, case alignment
  termsync    = false,
  wrap        = false,
  writebackup = false, -- no need this with undo history plugin
  completeopt = "menu,menuone,noinsert,noselect",
  guicursor   = "", -- i hate blink and vertical line
  hlsearch    = false,
  ignorecase  = true, -- Ignore case when searching...
  smartcase   = true, -- ... unless there is a capital letter in the query
  matchtime   = 1, -- display of current match paren faster
  showmatch   = true, -- show matching brackets when text indicator is over them
  nu          = false,
  rnu         = false,
  ru          = true,
  showcmd     = true,
  laststatus  = 0,
  showmode    = true,
  signcolumn  = "yes:1",
  splitbelow  = true,
  splitright  = true,
  swapfile    = false,
  backup      = false,
  updatetime  = 50,
  undodir     = vim.fn.stdpath("data") .. "/undodir/",
  undofile    = true,
  wildcharm   = vim.fn.char2nr('^I'),
  winbar      = "%f %m",
  virtualedit = "block",
  pumheight   = 10,
  equalalways = false,
  mousemodel     = "extend",
  formatoptions  = "jql", -- :h fo-table
  termguicolors  = true,
}

if options.laststatus == 0 then
  options.statusline = "%{repeat('─',winwidth('.'))}"
end

-- fk u MS
if vim.fn.has("win32") == 1 then
  options.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  options.shellcmdflag = [[-NoLogo -ExecutionPolicy RemoteSigned ]]
    .. [[-Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();
        "$PSDefaultParameterValues['Out-File:Encoding']='utf8';
        "Remove-Alias -Force -ErrorAction SilentlyContinue tee;]]
  options.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  options.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  options.shellquote = ""
  options.shellxquote = ""
  options.shada = "!,'100,<50,s10,h" -- for command history
end

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- append options
local edits = {
  wildignore = { "*.o", "*~", "*.pyc", "*pycache*" },
  shortmess  = "c",
}

for k, v in pairs(edits) do
  vim.opt[k]:append(v)
end

vim.cmd [[
  filetype indent off
]]

local globals = {
  netrw_altfile = 1,
  netrw_cursor = 5,
  netrw_preview = 1,
  netrw_alto = 0,
  netrw_hide = 0,
  netrw_sizestyle= "h",
  editorconfig = false,
  loaded_matchit = 1,
  loaded_matchparen = 1,
  loaded_remote_plugins = 1,
  loaded_shada_plugin = 1,
  loaded_spellfile_plugin = 1,
  loaded_gzip = 1,
  loaded_tar = 1,
  loaded_tarPlugin = 1,
  loaded_zip = 1,
  loaded_zipPlugin = 1,
  loaded_ruby_provider = 0,
  loaded_python_provider = 0,
  loaded_python3_provider = 0,
  loaded_perl_provider = 0,
  loaded_node_provider = 0,
}

for k, v in pairs(globals) do
  vim.g[k] = v
end

local slow_fingers = {
  w   = { "W" },
  q   = { "Q" },
  x   = { "X" },
  wq  = { "WQ", "Wq" },
  wa  = { "WA", "Wa" },
  qa  = { "QA", "Qa" },
  wqa = { "WQA", "WQa", "Wqa" },
  xa  = { "XA", "Xa" },
}

for k, v in pairs(slow_fingers) do
  for _, new in ipairs(v) do
    vim.api.nvim_create_user_command(new, k, { bang = true, bar = true })
  end
end
