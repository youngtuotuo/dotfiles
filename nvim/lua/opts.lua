vim.opt.expandtab = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop = 4 -- <BS> delete 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- spaces for auto indent
vim.opt.smartindent = true -- auto indent when typing { & }
vim.opt.cinoptions = "l1" -- for switch, case alignment
vim.opt.termsync = false
vim.opt.conceallevel = 0
vim.opt.wrap = false
vim.opt.writebackup = false -- no need this with undo history plugin
vim.opt.guicursor = "" -- i hate blink and vertical line
vim.opt.hlsearch = false
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.nu = false
vim.opt.rnu = false
vim.opt.ru = true
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.signcolumn = "auto"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.completeopt = [[menu,menuone,noselect,popup]]
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildoptions = [[tagfile]]
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.virtualedit = "block"
vim.opt.fillchars = [[vert:|]]
vim.opt.pumheight = 10
vim.opt.equalalways = false
vim.opt.mousemodel = "extend"
vim.opt.formatoptions = "jql" -- :h fo-table
vim.opt.termguicolors = true
vim.opt.grepprg = [[grep -rn $*]]
vim.opt.path = [[.,**]]
vim.opt.shada = [[!,'100,<50,s10,h]]
vim.opt.listchars=[[trail:.]]
vim.opt.list = true

-- append options
vim.opt.shortmess:append("c")

-- :h netrw-browse-maps
vim.g.netrw_altfile = 1
vim.g.netrw_cursor = 5
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_hide = 0
vim.g.netrw_sizestyle = "h"
vim.g.editorconfig = false
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
-- vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.api.nvim_create_user_command("W", "w", { bang = true, bar = true })
vim.api.nvim_create_user_command("Q", "q", { bang = true, bar = true })
vim.api.nvim_create_user_command("X", "x", { bang = true, bar = true })
vim.api.nvim_create_user_command("WQ", "wq", { bang = true, bar = true })
vim.api.nvim_create_user_command("Wq", "wq", { bang = true, bar = true })
vim.api.nvim_create_user_command("WA", "wa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Wa", "wa", { bang = true, bar = true })
vim.api.nvim_create_user_command("QA", "qa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Qa", "qa", { bang = true, bar = true })
vim.api.nvim_create_user_command("WQA", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("WQa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Wqa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("XA", "xa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Xa", "xa", { bang = true, bar = true })
