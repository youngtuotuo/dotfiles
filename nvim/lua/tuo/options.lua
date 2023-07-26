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
    fillchars = 'stl: ',
    guicursor = 'a:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    hidden = true,
    pumheight = 7,
    ignorecase = true,
    laststatus = 3,
    matchtime = 1,
    mouse = "a",
    mousemoveevent = true,
    nu = false,
    rnu = false,
    ru = true,
    scrolloff = 2,
    shiftwidth = 4,
    showcmd = true,
    showmatch = true,
    showmode = false,
    signcolumn = 'auto:2',
    smartcase = true,
    smartindent = false,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    splitkeep = 'screen',
    swapfile = false,
    termguicolors = true,
    updatetime = 100,
    viminfo = "'1000",
    visualbell = false,
    wrap = true,
    writebackup = false
}

for k, v in pairs(options) do vim.opt[k] = v end

local yank_augroup = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end, group = yank_augroup})
vim.api.nvim_create_autocmd("BufEnter", {callback = function() vim.opt.formatoptions:remove{"c", "r", "o"} end})

vim.opt.shortmess:append "c"
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.iskeyword:append "-"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "html,c,cpp,yaml,json",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end
})

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
