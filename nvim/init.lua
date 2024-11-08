local function directory_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory"
end

-- plugins
local plugin_dir = vim.fn.stdpath("config") .. "/pack/plug/start"

if directory_exists(plugin_dir .. "/nvim-treesitter") then
    require("nvim-treesitter.configs").setup({
        indent = { enable = false, },
        highlight = { enable = false },
        incremental_selection = { enable = false, },
        -- bash, c, lua, markdown, markdown_inline, python, query, vim, vimdoc are all ported by default
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ai"] = "@conditional.outer",
                    ["ii"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                },
                include_surrounding_whitespace = false,
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                    ["]i"] = "@conditional.outer",
                    ["]w"] = "@loop.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                    ["]I"] = "@conditional.outer",
                    ["]W"] = "@loop.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                    ["[i"] = "@conditional.outer",
                    ["[w"] = "@loop.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                    ["[I"] = "@conditional.outer",
                    ["[W"] = "@loop.outer",
                },
            },
        },
    })
end

if directory_exists(plugin_dir .. "/nvim-surround") then
    require("nvim-surround").setup({})
end

P = function(v) print(vim.inspect(v)) return v end

vim.cmd[[
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis
]]

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "c_", "c^", { nowait = true, noremap = true })

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true })

vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.keymap.set({ "v" }, "p", [["_dP]], { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] })
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true })
vim.keymap.set({ "n" }, "<C-x>c", ":sp|term ", { noremap = true })

-- \q, [q, ]q for tpope's unimpaired
vim.keymap.set({ "n" }, "<leader>q", function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win.quickfix == 1 and win.loclist == 0 then vim.cmd.cclose() return end
    end
    vim.cmd.copen()
end, { nowait = true, noremap = true, desc = "toggle quickfix window" })
vim.keymap.set({ "n" }, "]q", function() vim.cmd([[try | cnext | catch | cfirst | catch | endtry]]) end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[q", function() vim.cmd([[try | cprev | catch | clast  | catch | endtry]]) end, { nowait = true, noremap = true })

-- \p, [p, ]p for my muscle memory
vim.keymap.set({ "n" }, "<leader>p", function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win.quickfix == 1 and win.loclist == 0 then vim.cmd.cclose() return end
    end
    vim.cmd.copen()
end, { nowait = true, noremap = true, desc = "toggle quickfix window" })
vim.keymap.set({ "n" }, "]p", function() vim.cmd([[try | cnext | catch | cfirst | catch | endtry]]) end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[p", function() vim.cmd([[try | cprev | catch | clast  | catch | endtry]]) end, { nowait = true, noremap = true })

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
vim.keymap.set({ "n" }, "]l", function() vim.cmd([[try | lnext | catch | lfirst | catch | endtry]]) end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[l", function() vim.cmd([[try | lprev | catch | llast  | catch | endtry]]) end, { nowait = true, noremap = true })

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.matchtime = 1
vim.opt.showmatch = true
vim.opt.completeopt = [[menu,menuone,preview,fuzzy]]
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.listchars = [[tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$]]
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.fillchars:append("vert:|")
vim.opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]

if vim.fn.has("win32") == 1 then
    vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

vim.filetype.add({
    extension = {
        h = "c",
    },
})

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt.formatoptions = "jql"
        vim.treesitter.stop()
    end,
})
vim.api.nvim_create_autocmd({"ColorScheme"}, {
    group = group,
    callback = function() 
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "Grey15", ctermbg = 235 })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "Yellow", ctermfg = 11 })
        vim.api.nvim_set_hl(0, "Visual", { fg = "none", ctermfg = "none", bg = "Grey20", ctermbg = 238 })
        vim.api.nvim_set_hl(0, "Comment", { fg = "NvimDarkGrey4", ctermfg = "darkgrey" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "NvimDarkGrey3", ctermbg = 239 })
        vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 232, ctermbg = 254, fg = "Black", bg = "DarkGrey" })
        vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "none", bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = true })
        vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" })
        vim.api.nvim_set_hl(0, "VertSplit", { cterm = {reverse = true}, reverse = true })
        vim.api.nvim_set_hl(0, "netrwMarkFile", { ctermfg=209, fg=209 })
    end,
})
vim.cmd.colo[[vim]]
