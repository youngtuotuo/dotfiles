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

for k, v in pairs(options) do vim.opt[k] = v end

vim.opt.shortmess:append "c"

local globals = {
  netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+",
  netrw_banner = 0,
  loaded_2html_plugin = 1,
  loaded_getscript = 1,
  loaded_getscriptPlugin = 1,
  loaded_gzip = 1,
  loaded_logiPat = 1,
  loaded_matchit = 1,
  loaded_matchparen = 1,
  loaded = 1,
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  loaded_netrwSettings = 1,
  loaded_node_provider = 0,
  loaded_perl_probider = 0,
  loaded_python3_provider = 0,
  loaded_rrhelper = 1,
  loaded_tar = 1,
  loaded_tarPlugin = 1,
  loaded_vimball = 1,
  loaded_vimballPlugin = 1,
  loaded_zip = 1,
  loaded_zipPlugin = 1
}

for k, v in pairs(globals) do vim.g[k] = v end

local yank_augroup = vim.api
                         .nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yank_augroup
})

vim.cmd [[set whichwrap+=<,>,[,],h,l]]
vim.cmd [[set iskeyword+=-]]

vim.api.nvim_create_autocmd("BufEnter", {command = "set formatoptions-=cro "})

local filetype_augroup = vim.api.nvim_create_augroup("FileTypeIndent",
                                                     {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua,c,cpp",
  command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
  group = filetype_augroup
})
