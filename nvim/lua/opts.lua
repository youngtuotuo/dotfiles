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
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.ru = true
vim.opt.showcmd = false
vim.opt.laststatus = 1
vim.opt.showmode = true
vim.opt.signcolumn = "auto"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.completeopt = [[menu,menuone,noselect,popup]]
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.wildoptions = [[tagfile]]
vim.opt.wildignore = [[*.o,*.obj,*.aux,*.fdb_latexmk,*.fls,*.out,*.synctex.gz,*.pyc,*pycache*,lib/python*,lib64/python*,*.git/*]]
vim.opt.virtualedit = "block"
vim.opt.fillchars = [[vert:|]]
vim.opt.pumheight = 10
vim.opt.equalalways = false
vim.opt.mousemodel = "extend"
vim.opt.formatoptions = "jql" -- :h fo-table
vim.opt.termguicolors = false
vim.opt.grepprg = [[grep -rn $*]]
vim.opt.grepformat:append({ [[%l:%m]] })
vim.opt.path = [[.,,**]]
vim.opt.shada = [[!,'100,<50,s10,h]]
vim.opt.listchars=[[tab:>-,trail:.]]
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
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
-- vim.g.loaded_remote_plugins = 1
-- vim.g.loaded_shada_plugin = 1
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

-- diagnostic
local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    header = "",
    prefix = "",
    focusable = true,
    title = " σ`∀´)σ ",
    border = _G.border,
    source = true,
  },
}

vim.diagnostic.config(diag_config)

-- float win
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = _G.border
  opts.max_width = _G.floatw
  opts.max_height = _G.floath
  opts.wrap = _G.floatwrap
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

