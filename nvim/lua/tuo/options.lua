local options = {
  -- winbar = "%f %m",
  backspace = "indent,eol,start",
  backup = false,
  clipboard = "unnamedplus",
  completeopt = {"menuone", "noselect"},
  cursorline = true,
  errorbells = false,
  expandtab = true,
  fileencoding = "utf-8",
  fillchars = 'stl: ',
  guifont = "Hack NF:h13",
  hidden = false,
  ignorecase = true,
  laststatus = 3,
  matchtime = 1,
  mouse = "a",
  nu = true,
  rnu = true,
  scrolloff = 5,
  shiftwidth = 4,
  showmatch = true,
  showmode = true,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  updatetime = 400,
  viminfo = "'1000",
  visualbell = false,
  wrap = false,
  writebackup = false
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do vim.opt[k] = v end

local globals = {
  netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+",
  netrw_banner = 0,
  loaded_python3_provider = 0,
  loaded_node_provider = 0,
  loaded_perl_probider = 0
}

for k, v in pairs(globals) do vim.g[k] = v end

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.cmd [[
  syntax on
  filetype indent on
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
  autocmd FileType lua,c,cpp setlocal shiftwidth=2 softtabstop=2 expandtab
]]
