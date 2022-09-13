HOME = os.getenv("HOME")

vim.opt.guifont="Hack NF:h13"
vim.opt.completeopt="menu,menuone,noselect"
vim.opt.encoding = "utf-8"
vim.opt.backspace = "indent,eol,start"
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hidden = false
vim.opt.mouse = 'a'
vim.opt.laststatus = 2
vim.opt.fillchars = 'stl: '
-- vim.opt.winbar = "%f %m"
vim.opt.nu = true
vim.opt.rnu = true
-- vim.wo.colorcolumn = "81"
vim.opt.cursorline = true

-- netrw
vim.g.netrw_list_hide = "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
vim.g.netrw_banner = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_probider = 0

-- Parathensis match
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- search control
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.viminfo = "'1000"
vim.opt.showmode = true

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- <tab> control
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.shiftwidth = 4

vim.opt.updatetime = 400

vim.cmd [[
  syntax on
  filetype indent on
  set shortmess+=c
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
  autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2 expandtab
]]
