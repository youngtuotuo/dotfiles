vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes:1"
vim.opt.colorcolumn = "111"

vim.keymap.set({ "i", "n" }, "<C-c>", "<esc>", { noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.keymap.set({ "n" }, "gt", function()
    local commentstring = vim.api.nvim_get_option_value("commentstring", { scope = "local" })
    local comment_prefix = commentstring:gsub(" %%s", "")
    vim.cmd([[:lvim /]] .. comment_prefix .. [[\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope]])
end, { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.lsp.config["ruff"] = {
    cmd = { 'ruff', 'server' },
    filetypes = { "python" },
    root_markers = { "ruff.toml" },
}
vim.lsp.enable("ruff")

-- vim.lsp.config["tylsp"] = {
--     cmd = { "ty", "server" },
--     filetypes = { "python" },
--     root_markers = { "ruff.toml" },
-- }
-- vim.lsp.enable("tylsp")
--
vim.diagnostic.config({ virtual_text = true })

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

require("lazy").setup({
    install = { colorscheme = { "default" } },
    spec = {
        { "junegunn/vim-easy-align" },
        { "czheo/mojo.vim", ft = { "mojo" } },
        { "tpope/vim-fugitive", cmd = { "G" } },
        { "nvim-tree/nvim-web-devicons", opts = {} },
        { "danymat/neogen", cmd = { "Neogen" }, config = true, version = "*" },
        { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
        {
            'Wansmer/treesj',
            cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
            dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
            opts = {}
        },
        {
            "numToStr/Comment.nvim", 
            opts = {
                pre_hook = function(ctx)
                    local U = require 'Comment.utils'

                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = {
                            ctx.range.srow - 1,
                            ctx.range.scol,
                        }
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring').calculate_commentstring {
                        key = type,
                        location = location,
                    }
                end
            }
        },
        {
            "stevearc/aerial.nvim",
            keys = { {"go", "<cmd>AerialToggle!<CR>", mode = {"n", "v"}} },
            opts = {},
            dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        },
        {
            "stevearc/oil.nvim",
            opts = { view_options = { show_hidden = true } },
            init = function()
                vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
            end
        },
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = { styles = { comments = { italic = false }, keywords = { italic = false }, } },
            init = function()
                vim.cmd.colo [[tokyonight-night]]
            end
        },
        {
            'ThePrimeagen/refactoring.nvim',
            dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", },
            opts = {}
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = ":call mkdp#util#install",
            config = function()
                vim.g.mkdp_open_to_the_world = 1
                vim.g.mkdp_echo_preview_url = 1
                vim.g.mkdp_port = '8088'
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {"nvim-treesitter/nvim-treesitter"}
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = { "python" },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        include_surrounding_whitespace = false,
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                            --
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            },
            config = function(_, opts)
                require'nvim-treesitter.configs'.setup(opts)
            end
        },
        {
            "junegunn/fzf",
            cmd = { "FZF" },
            build = ":call fzf#install",
            init = function()
                vim.g.fzf_layout = { down = "40%" }
            end
        },
        {
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            keys = {
                {
                    "<leader>f",
                    function()
                        require("conform").format()
                    end,
                    mode = { "n", "v"},
                },
            },
            opts = {
                formatters_by_ft = {
                    -- python = { "ruff_format", "ruff_organize_imports" },
                    python = { "ruff_organize_imports" },
                },
            },
            init = function()
                vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            end
        },
        {
            "kylechui/nvim-surround",
            version = "^3.0.0",
            event = "VeryLazy",
            opts = {}
        },
        {
            "saghen/blink.cmp",
            dependencies = { "rafamadriz/friendly-snippets" },
            version = "1.*",
            opts = {
                cmdline = {
                    keymap = { preset = 'inherit' },
                    completion = { menu = { auto_show = false } },
                },
                completion = {
                    menu = {
                        auto_show = false,
                        draw = {
                            columns = { { "kind_icon" }, { "label" }, { "source_name" }}
                        }
                    }
                },
                keymap = {
                    ["<C-n>"] = { "show_and_insert", "select_next", "fallback" },
                    ["<C-space>"] = {},
                },
                sources = {
                    default = function(ctx)
                        local success, node = pcall(vim.treesitter.get_node)
                        if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                            return { "path", "buffer" }
                        else
                            return { "lsp", "path", "snippets", "buffer" }
                        end
                    end,
                    providers = {
                        cmdline = {
                            -- ignores cmdline completions when executing shell commands
                            enabled = function()
                                return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                            end
                        },
                        path = {
                            opts = { get_cwd = function(_) return vim.fn.getcwd() end, },
                        },
                    }
                },
            },
        }
    },
})

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}

    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end

    -- Apply syntax highlighting for quickfix window
    vim.schedule(function()
        vim.cmd [[
            " Clear existing quickfix syntax to avoid conflicts
            syntax clear
            " Match filename (up to the separator │)
            syntax match qfFileName /^[^│]*/ contained containedin=qfLine
            " Match line and column numbers (e.g., 123:45)
            syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
            " Match error/warning type (e.g., ' E' or ' W')
            syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
            " Match the entire valid line
            syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
            " Link highlight groups to default quickfix highlights
            highlight default link qfFileName Directory
            highlight default link qfLineNr LineNr
            highlight default link qfType Type
        ]]
    end)
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
