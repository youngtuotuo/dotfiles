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
    hidden = false,
    ignorecase = true,
    laststatus = 2,
    matchtime = 1,
    mouse = "a",
    nu = false,
    rnu = false,
    ru = true,
    scrolloff = 8,
    shiftwidth = 4,
    showcmd = false,
    showmatch = true,
    showmode = true,
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

vim.opt.shortmess:append "c"

local yank_augroup = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {command = "silent! lua vim.highlight.on_yank()", group = yank_augroup})

vim.cmd [[set whichwrap+=<,>,[,],h,l]]
vim.cmd [[set iskeyword+=-]]

vim.api.nvim_create_autocmd("BufEnter", {command = "set formatoptions-=cro "})
