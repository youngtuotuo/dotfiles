-- fk u MS
_G.sep = vim.fn.has("win32") == 1 and [[\]] or "/"
_G.home = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
_G.ext = vim.fn.has("win32") == 1 and ".exe" or ""

-- lazy bootstrap
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local check_git_repo = function()
    local output = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
    return #output ~= 0
end

local get_lan_ip = function()
    if vim.fn.has("win32") == 1 then
        local output = vim.fn.system("ipconfig")
        local lan_ip = output:match("IPv4 Address.-:%s192([%d%.]+)")
        return "192" .. lan_ip
    elseif vim.fn.has("mac") == 1 then
        local cmd = "ipconfig getifaddr en0"
        local ip = vim.fn.system(cmd):match("([%d%.]+)%\n")
        return ip
    elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
        local cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
        local ip = vim.fn.system(cmd)
        return ip:gsub("%s+", "") -- Remove any leading/trailing whitespace
    end
end

-- plugins
require("lazy").setup({
    ui = {
        border = "rounded",
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    change_detection = {
        notify = false,
    },
    spec = {
        {
            "iamcco/markdown-preview.nvim",
            build = "cd app && npm install",
            cmd = { "MarkdownPreview", "MP" },
            init = function()
                vim.api.nvim_create_user_command("MP", "MarkdownPreview", {})
            end,
            config = function()
                vim.g.mkdp_filetypes = { "markdown" }
                --  set to 1, nvim will open the preview window after entering the markdown buffer
                --  default: 0
                vim.g.mkdp_auto_start = 0

                --  set to 1, the nvim will auto close current preview window when change
                --  from markdown buffer to another buffer
                --  default: 1
                vim.g.mkdp_auto_close = 0

                --  set to 1, the vim will refresh markdown when save the buffer or
                --  leave from insert mode, default 0 is auto refresh markdown as you edit or
                --  move the cursor
                --  default: 0
                vim.g.mkdp_refresh_slow = 0

                --  set to 1, the MarkdownPreview command can be use for all files,
                --  by default it can be use in markdown file
                --  default: 0
                vim.g.mkdp_command_for_global = 0

                --  set to 1, preview server available to others in your network
                --  by default, the server listens on localhost (127.0.0.1)
                --  default: 0
                vim.g.mkdp_open_to_the_world = 1

                --  use custom IP to open preview page
                --  useful when you work in remote vim and preview on local browser
                --  more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
                --  default empty
                -- vim.g.mkdp_open_ip = "127.0.0.1"
                vim.g.mkdp_open_ip = get_lan_ip()

                --  specify browser to open preview page
                --  default: ''
                vim.g.mkdp_browser = ""

                --  set to 1, echo preview page url in command line when open preview page
                --  default is 0
                vim.g.mkdp_echo_preview_url = 1

                --  a custom vim function name to open preview page
                --  this function will receive url as param
                --  default is empty
                vim.g.mkdp_browserfunc = ""

                --  use a custom markdown style must be absolute path
                --  like '/Users/username/markdown.css' or expand('~/markdown.css')
                vim.g.mkdp_markdown_css = ""

                --  use a custom highlight style must absolute path
                --  like '/Users/username/highlight.css' or expand('~/highlight.css')
                vim.g.mkdp_highlight_css = ""

                --  use a custom port to start server or random for empty
                vim.g.mkdp_port = "8085"

                --  preview page title
                --  ${name} will be replace with the file name
                vim.g.mkdp_page_title = "「${name}」"

                vim.g.mkdp_theme = "light"
            end,
        },
        {
            "tpope/vim-fugitive",
            cond = check_git_repo,
            cmd = { "G", "Git" },
        },
        {
            "tpope/vim-vinegar"
        },
        {
            "chrisgrieser/nvim-various-textobjs",
            opts = { useDefaultKeymaps = false },
            config = function(_, opts)
                require("various-textobjs").setup(opts)
                vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
                vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
            end,
        },
        {
            "kylechui/nvim-surround",
            -- Use for stability; omit to use `main` branch for the latest features
            version = "*",
            opts = {},
        },
        {
            "windwp/nvim-ts-autotag",
            ft = { "html", "xml" },
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
            opts = {
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            },
            config = function(_, opts)
                require("nvim-ts-autotag").setup(opts)
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            cmd = { "TSUpdate" },
            ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust", "mojo" },
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            version = false,
            build = ":TSUpdate",
            ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust", "mojo" },
            opts = {
                indent = {
                    enable = false,
                },
                highlight = false,
                incremental_selection = {
                    enable = false,
                },
                -- bash, c, lua, markdown, markdown_inline, python, query, vim, vimdoc are all ported by default
                ensure_installed = {
                    -- "bash",
                    -- "c",
                    "cpp",
                    "cuda",
                    -- "lua",
                    -- "markdown",
                    -- "markdown_inline",
                    -- "python",
                    -- "query",
                    -- "vim",
                    -- "vimdoc",
                    "html",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "zig",
                    "rust",
                },
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
                            ["]l"] = "@loop.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                            ["]I"] = "@conditional.outer",
                            ["]L"] = "@loop.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                            ["[i"] = "@conditional.outer",
                            ["[l"] = "@loop.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                            ["[I"] = "@conditional.outer",
                            ["[L"] = "@loop.outer",
                        },
                    },
                },
                matchup = {
                    enable = true, -- mandatory, false will disable the whole extension
                    disable_virtual_text = true,
                },
            },
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
        },
    }
})

local group = vim.api.nvim_create_augroup("TuoGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt.formatoptions = "jql"
        vim.treesitter.stop()
    end,
    desc = "All buffer need formatoptions = jql",
})

-- print(vim.inspect(v))
P = function(v)
    print(vim.inspect(v))
    return v
end

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set(
    { "n" },
    "c_",
    "c^",
    { nowait = true, noremap = true }
)

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true })

vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.keymap.set(
    { "v" },
    "p",
    [["_dP]],
    { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] }
)
vim.keymap.set({ "n" }, "<M-j>", "<cmd>move+1<cr>", { noremap = true })
vim.keymap.set(
    { "v" },
    "J",
    ":move '>+1<CR>gv=gv",
    { noremap = true }
)
vim.keymap.set({ "n" }, "<M-k>", "<cmd>move--1<cr>", { noremap = true })
vim.keymap.set(
    { "v" },
    "K",
    ":move '<-2<CR>gv=gv",
    { noremap = true }
)
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true })
vim.keymap.set({ "n" }, "<C-x>c", ":sp|term ", { noremap = true })

vim.keymap.set({ "n" }, "]p", function()
    vim.cmd([[try | cnext | catch | cfirst | catch | endtry]])
end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[p", function()
    vim.cmd([[try | cprev | catch | clast  | catch | endtry]])
end, { nowait = true, noremap = true })

vim.keymap.set({ "n" }, "]l", function()
    vim.cmd([[try | lnext | catch | lfirst | catch | endtry]])
end, { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "[l", function()
    vim.cmd([[try | lprev | catch | llast  | catch | endtry]])
end, { nowait = true, noremap = true })

vim.opt.expandtab = true -- <Tab> to space char, CTRL-V-I to insert real tab
vim.opt.softtabstop = 4 -- <BS> delete 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- spaces for auto indent
vim.opt.smartindent = true -- auto indent when typing { & }
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.matchtime = 1 -- display of current match paren faster
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.completeopt = [[menu,menuone,preview,fuzzy]]
vim.opt.swapfile = false
vim.opt.updatetime = 50
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir/"
vim.opt.undofile = true
vim.opt.wildcharm = vim.fn.char2nr("^I")
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.listchars = [[tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$]]
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.fillchars:append("vert:|")

vim.opt.grepformat:append({ [[%l:%m]] })
vim.opt.cinkeys:remove(":")

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
