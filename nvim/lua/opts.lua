vim.opt.expandtab     = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop   = 4 -- <BS> delete 4 spaces
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4 -- spaces for auto indent
vim.opt.smartindent   = true -- auto indent when typing { & }
vim.opt.cinoptions    = "l1" -- for switch, case alignment, :h cino-l
vim.opt.laststatus    = 0
vim.opt.ignorecase    = true -- Ignore case when searching...
vim.opt.smartcase     = true -- ... unless there is a capital letter in the query
vim.opt.guicursor     = [[]]
vim.opt.matchtime     = 1 -- display of current match paren faster
vim.opt.showmatch     = true -- show matching brackets when text indicator is over them
vim.opt.splitright    = true
vim.opt.splitbelow    = true
vim.opt.swapfile      = false
vim.opt.updatetime    = 50
vim.opt.completeopt   = [[menu,menuone,noselect,popup]]
vim.opt.undodir       = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile      = true
vim.opt.wildcharm     = vim.fn.char2nr("^I")
vim.opt.virtualedit   = "block"
vim.opt.mousemodel    = "extend"
vim.opt.formatoptions = "jql"  -- :h fo-table
vim.opt.shada         = [[!,'100,<50,s10,h]]
vim.opt.listchars     = [[tab:>-,trail:.]]
vim.opt.list          = true

vim.opt.grepformat:append({ [[%l:%m]] })
vim.opt.cinkeys:remove(":")
vim.opt.indentkeys:remove("<:>")
vim.opt.shortmess:append("c")

-- :h netrw-browse-maps
vim.g.netrw_altfile           = 1
vim.g.netrw_cursor            = 5
vim.g.netrw_preview           = 1
vim.g.netrw_alto              = 0
vim.g.netrw_hide              = 0
vim.g.netrw_sizestyle         = "h"
vim.g.editorconfig            = true
vim.g.loaded_gzip             = 1
vim.g.loaded_tar              = 1
vim.g.loaded_tarPlugin        = 1
vim.g.loaded_zip              = 1
vim.g.loaded_zipPlugin        = 1
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_python_provider  = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

if vim.fn.has("win32") == 1 then
  if vim.fn.executable("nu") == 1 then
    vim.opt.shell = "nu"
  else
    vim.opt.shell        = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir   = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe    = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote   = ""
    vim.opt.shellxquote  = ""
  end
end

vim.api.nvim_set_hl(0, "Normal",        { ctermbg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "luaParenError", { link    = "Normal" })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { link = "Normal" })
vim.api.nvim_set_hl(0, "Statement",     { ctermfg = 81,  fg = "#65d1d8", bold = true, nocombine = false })
vim.api.nvim_set_hl(0, "Boolean",       { ctermfg = 111, fg = "#89aee3", bold = true, nocombine = false })
vim.api.nvim_set_hl(0, "Function",      { ctermfg = 153, fg = "#9abcdc", bold = true, nocombine = false })
vim.api.nvim_set_hl(0, "Special",       { ctermfg = 153, fg = "#9abcdc", bold = true, nocombine = false })
vim.api.nvim_set_hl(0, "ModeMsg",       { ctermfg = "NONE", fg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "Operator",      { ctermfg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat",   { ctermbg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",   { link    = "Label"})
vim.api.nvim_set_hl(0, "CursorLine",    { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "Conceal",       { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn",    { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MatchParen",    { ctermfg = 81, fg = "#65d1d8" })
vim.api.nvim_set_hl(0, "String",        { ctermfg = 158, fg = "#97eed6" })
vim.api.nvim_set_hl(0, "Identifier",    { ctermfg = 255, fg = "#eaeaea" })
vim.api.nvim_set_hl(0, "Comment",       { ctermfg = 244, fg = "#7a7e7a" })
vim.api.nvim_set_hl(0, "Visual",        { ctermbg = 237, bg = "#393939" })
vim.api.nvim_set_hl(0, "IlluminatedWordText",  { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead",  { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
