P = function(v) print(vim.inspect(v)) return v end

vim.cmd[[
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
]]

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "c_", "c^", { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "Q", "gq", { nowait = true, noremap = true })
vim.keymap.set({ "s" }, "Q", "<Nop>", { nowait = true, noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "i" }, "<C-u>", "<C-g>u<C-u>", { noremap = true })
vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })
vim.keymap.set({ "v" }, "p", [["_dP]], { noremap = true, desc = [[Paste over currently selected text without yanking it]] })
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true })
vim.keymap.set({ "n" }, "<C-x>c", ":sp|term ", { noremap = true })

-- \p, [p, ]p for my muscle memory
vim.keymap.set({ "n" }, "<leader>p", function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win.quickfix == 1 and win.loclist == 0 then vim.cmd.cclose() return end
    end
    vim.cmd.copen()
end, { nowait = true, noremap = true, desc = "toggle quickfix window" })
vim.keymap.set({ "n" }, "]p", ":cnext<cr>", { silent = true, nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[p", ":cprev<cr>", { silent = true, nowait = true, noremap = true })

-- \l, [l, ]l for tpope's unimpaired
vim.keymap.set({ "n" }, "<leader>l", function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win.loclist == 1 then vim.cmd.lclose() return end
    end
    if #vim.fn.getloclist(0) > 0 then vim.cmd.lopen()
    else vim.notify("[WARN] No location list.", vim.log.levels.WARN)
    end
end, { nowait = true, noremap = true, desc = "toggle location list" })

vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.completeopt = [[menu,preview,fuzzy]]
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.listchars:append([[eol:$]])
vim.opt.inccommand = "split"
vim.opt.fillchars:append("vert:|,fold:-,eob:~")
vim.opt.wrapscan = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.wildmenu = false

if vim.fn.has("win32") == 1 then
    vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';$PSStyle.OutputRendering=''plaintext'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

vim.api.nvim_create_augroup("Tuo", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "Tuo",
    callback = function()
        vim.treesitter.stop()
    end,
})

vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
    group = "Tuo",
    callback = function() 
        vim.api.nvim_set_hl(0, "Visual", { fg = "none", ctermfg = "none", bg = "Grey20", ctermbg = 238 })
        vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" })
        vim.api.nvim_set_hl(0, "Comment", { fg = "NvimDarkGrey4", ctermfg = "darkgrey" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "NvimDarkGrey3", ctermbg = 239 })
        vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 232, ctermbg = 254, fg = "Black", bg = "DarkGrey" })
        vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })
        vim.api.nvim_set_hl(0, "WinSeparator", { cterm = {reverse = true}, reverse = true })
        vim.api.nvim_set_hl(0, "VertSplit", { link = "WinSeparator" })
        vim.api.nvim_set_hl(0, "netrwMarkFile", { ctermfg=209, fg=209 })
    end,
})

vim.g.netrw_cursor = 0
vim.g.fzf_layout = { down = [[40%]] }
vim.keymap.set({ "n" }, "<space>o", ":Tagbar<cr>", { silent=true, noremap = true })
vim.g.tagbar_width = math.min(60, vim.fn.winwidth(0) / 3)
