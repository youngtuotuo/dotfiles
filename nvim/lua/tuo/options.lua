local options = {
    backspace = "indent,eol,start",
    backup = false,
    completeopt = "menuone,noinsert,noselect",
    cursorline = false,
    cmdheight = 1,
    errorbells = false,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = 'stl: ',
    guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175',
    hidden = true,
    pumheight = 7,
    ignorecase = true,
    laststatus = 3,
    matchtime = 1,
    mouse = "a",
    mousemoveevent = true,
    nu = true,
    rnu = true,
    ru = true,
    scrolloff = 2,
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

