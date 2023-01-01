local options = {
    backspace = "indent,eol,start",
    backup = false,
    clipboard = "unnamedplus",
    completeopt = {},
    cursorline = false,
    errorbells = false,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = 'stl: ',
    hidden = true,
    ignorecase = true,
    laststatus = 3,
    matchtime = 1,
    mouse = "a",
    nu = false,
    rnu = false,
    ru = true,
    scrolloff = 8,
    shiftwidth = 4,
    showcmd = false,
    showmatch = true,
    showmode = false,
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    termguicolors = true,
    updatetime = 200,
    viminfo = "'1000",
    visualbell = false,
    wrap = false,
    writebackup = false
}

for k, v in pairs(options) do vim.opt[k] = v end


local yank_augroup = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end, group = yank_augroup})
vim.api.nvim_create_autocmd("BufEnter", {callback = function() vim.opt.formatoptions:remove {"c","r","o"} end})

vim.opt.shortmess:append "c"
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.iskeyword:append "-"

